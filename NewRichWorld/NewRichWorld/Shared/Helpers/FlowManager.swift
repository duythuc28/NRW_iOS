//
//  FlowManager.swift
//  Chantier
//
//  Created by Imac on 8/2/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation
import UIKit

final class FlowManager {
  
  static func presentRecentLogin(navigationController : UINavigationController) {
    
    let recentLoginController = CTRecentLoginViewController.instantiateFromStoryboard()
    navigationController.viewControllers = [recentLoginController]
  }
  
  static func presentLogin(navigationController : UINavigationController) {
    let loginViewController = CTLoginViewController.instantiateFromStoryboard()
    navigationController.viewControllers = [loginViewController]
  }
  
  static func presentHome(navigationController : UINavigationController) {
    let homePageViewController = CTHomePageViewController.instantiateFromStoryboard("Dashboard")
    navigationController.pushViewController(homePageViewController, animated: true)
  }
  
  static func presentDashboard(navigationController : UINavigationController) {
    
  }
  
  // MARK: Private Method
  private static func firstViewControllerFromStoryboard(storyboardName:String)->UIViewController? {
      let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
      let vc = storyboard.instantiateInitialViewController()
      return vc
  }
}

// MARK: CTNavigationBarView
// MARK: Loading data when online login
extension FlowManager {
  static func loadDataAfterLogin(completion: (()->())?) {
    CTOppAPI.getPreventionContentsLast { (result, error) in
      if error == nil {
        // Save document and theme
        CTThemeLoader.sharedInstance.updateOrAddWith(result!)
        // Load image of document and save to local db
        for document in result! {
          RESTRequest.downloadImage(document.image, completion: { (filename) in
            dispatch_async(dispatch_get_main_queue(), {
              CTDocumentLoader.sharedInstance.updatePreviewImage(document.id, localPath: filename)
            })
          })
          
          RESTRequest.downloadImage(document.themeImage, completion: { (filename) in
            dispatch_async(dispatch_get_main_queue(), {
              CTThemeLoader.sharedInstance.updateLocalImage(document.themeId, localPath: filename)
            })
          })
        }
      }
      
      // Load organizations
      CTUserAPI.getListOrganizations({ (result, error) in
        if error == nil {
          for organisation in CTOrganisationLoader.sharedInstance.saveOrUpdate(result!) {
            RESTRequest.downloadImage(organisation.logo, completion: { (imageName) in
              dispatch_async(dispatch_get_main_queue(), { 
                CTOrganisationLoader.sharedInstance.updateLogo(organisation.id, imageName: imageName)
              })
            })
          }
        }
        completion?()
      })
    }
    
    // Create a work log setting
    CTSettingLoader.sharedInstance.createDefaultSetting(CTUserInformation.sharedInstance.user)
  }
}
// MARK: BaseViewController
extension FlowManager {

  static func presentProfile(navigationController: UINavigationController) {
    let profileViewController = CTProfileViewController.instantiateFromStoryboard("Main")
    navigationController.pushViewController(profileViewController, animated: true)
  }
  
  static func presentAccident(navigationController: UINavigationController) {
    let accidentViewController = CTAccidentViewController.instantiateFromStoryboard("Main")
    navigationController.pushViewController(accidentViewController, animated: true)
  }
  
  static func presentSettings(navigationController: UINavigationController) {
    let settingsViewController = CTSettingMainViewController.instantiateFromStoryboard("Main")
    navigationController.pushViewController(settingsViewController, animated: true)
  }
}

// MARK: Home screen
extension FlowManager {
  static func presentSite(navigationController : UINavigationController, site: CTSite) {
    
    guard let localSite = CTSiteLoader.sharedInstance.query("id = \(site.id)").first as? CTSite else { return }
    
    let constructionViewController = CTConstructionViewController.instantiateFromStoryboard("Contructor")
    constructionViewController.siteInfo = localSite
    navigationController.pushViewController(constructionViewController, animated: true)
  }
  
  static func presentBusinessNews(navigationController : UINavigationController, organisation: CTOrganisation) {
    let businessNewsViewController = CTBusinessNewsViewController.instantiateFromStoryboard("BusinessNews")
    businessNewsViewController.organisation = organisation
    FlowTagging.businessNewsScreen()
    navigationController.pushViewController(businessNewsViewController, animated: true)
  }
  
  static func presentBusinessNewsDetail(navigationController : UINavigationController,organisation: CTOrganisation, news: CTNews) {
    let businessNewsViewController = CTBusinessNewsViewController.instantiateFromStoryboard("BusinessNews")
    businessNewsViewController.news = news
    businessNewsViewController.organisation = organisation
    navigationController.pushViewController(businessNewsViewController, animated: true)
  }
  
  static func presentCorporateDocument(navigationController : UINavigationController, organisation: CTOrganisation) {
    let corporateDocumentViewController = CTCorporateDocumentViewController.instantiateFromStoryboard("BusinessNews")
    corporateDocumentViewController.organisation = organisation
    navigationController.pushViewController(corporateDocumentViewController, animated: true)
  }
  
  static func presentPrevention(navigationController : UINavigationController, organisation: CTOrganisation) {
    let preventionViewController = CTPreventionViewController.instantiateFromStoryboard("Prevention")
    preventionViewController.organisation = organisation
    navigationController.pushViewController(preventionViewController, animated: true)
  }
  
  static func presentPreventionDetail(navigationController : UINavigationController, organisation: CTOrganisation, documentLast: CTDocument) {
    let preventionViewController = CTPreventionViewController.instantiateFromStoryboard("Prevention")
    preventionViewController.pushPreventionDetail = true
    preventionViewController.documentLast = documentLast
    preventionViewController.organisation = organisation
    navigationController.pushViewController(preventionViewController, animated: true)
  }
  
  static func presentNewsOPPBTP(navigationController : UINavigationController, organisation: CTOrganisation) {
    let preventionViewController = CTPreventionViewController.instantiateFromStoryboard("Prevention")
    preventionViewController.pushNewsOPPBTP = true
    preventionViewController.organisation = organisation
    navigationController.pushViewController(preventionViewController, animated: true)
  }
}

// MARK: Site screen
extension FlowManager {
  static func presentPointer(navigationController : UINavigationController, site: CTSite?) {
    let pointerViewController = CTPointerViewController.instantiateFromStoryboard("Contructor")
    pointerViewController.site = site
    navigationController.pushViewController(pointerViewController, animated: true)
  }
  
  static func presentWelcome(navigationController : UINavigationController, site: CTSite?) {
    let welcomeToSiteViewController = CTWelcomeToSiteViewController.instantiateFromStoryboard("Contructor")
    welcomeToSiteViewController.site = site
    navigationController.pushViewController(welcomeToSiteViewController, animated: true)
  }
  
  static func presentEvent(navigationController : UINavigationController, site: CTSite) {
    let eventViewController = CTEventViewController.instantiateFromStoryboard("Contructor")
    eventViewController.site = site
    navigationController.pushViewController(eventViewController, animated: true)
  }
  
  static func presentSiteDocument(navigationController : UINavigationController, site: CTSite) {
    let documentViewController = CTDocumentViewController.instantiateFromStoryboard("Contructor")
    documentViewController.site = site
    navigationController.pushViewController(documentViewController, animated: true)
  }
}

// MARK: Business News screen
extension FlowManager {
  
  static func presentBusinessNewsViewController(navigationController: UINavigationController) {
    let businessNewsViewController = CTBusinessNewsViewController.instantiateFromStoryboard("BusinessNews")
    navigationController.pushViewController(businessNewsViewController, animated: true)
  }
  
  static func presentBusinessNewsDetailViewController(navigationController: UINavigationController, organisation: CTOrganisation, news: CTNews) {
    let businessNewsDetailViewController = CTBusinessNewsDetailViewController.instantiateFromStoryboard("BusinessNews")
    businessNewsDetailViewController.organisation = organisation
    businessNewsDetailViewController.news = news
    navigationController.pushViewController(businessNewsDetailViewController, animated: true)
  }
  
  static func presentBusinessNewsDetailViewController(viewController: UIViewController, organisation: CTOrganisation, news: CTNews) {
    let businessNewsDetailViewController = CTBusinessNewsDetailViewController.instantiateFromStoryboard("BusinessNews")
    businessNewsDetailViewController.organisation = organisation
    businessNewsDetailViewController.news = news
    businessNewsDetailViewController.view.translatesAutoresizingMaskIntoConstraints = false
    
    viewController.addChildViewController(businessNewsDetailViewController)
    viewController.view.addSubview(businessNewsDetailViewController.view)
    
    viewController.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[detail]-0-|", options: [], metrics: nil, views: ["detail" : businessNewsDetailViewController.view]))
    viewController.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[detail]-0-|", options: [], metrics: nil, views: ["detail" : businessNewsDetailViewController.view]))
  }
}

// MARK: Event screen 
extension FlowManager {
  static func presentAddEventViewController(navigationController: UINavigationController, site: CTSite) {
    let addEventViewController = CTAddEventViewController.instantiateFromStoryboard("Contructor")
    addEventViewController.site = site
    navigationController.pushViewController(addEventViewController, animated: true)
  }
}


// MARK: CorporateDocument screen
extension FlowManager {
  static func presentListOfDocumentInCategoryViewController(navigationController: UINavigationController, category: CTCategory) {
    let listOfDocumentInCategoryViewController = CTListOfDocumentInCategoryViewController.instantiateFromStoryboard("BusinessNews")
    listOfDocumentInCategoryViewController.category = category
    navigationController.pushViewController(listOfDocumentInCategoryViewController, animated: true)
  }
}

// MARK: OPPNews
extension FlowManager {
  static func presentNewsOPPBTPDetailsViewController(navigationController: UINavigationController, news: CTNews) {
    let newsOPPBTPDetailsViewController = CTNewsOPPBTPDetailsViewController.instantiateFromStoryboard("Prevention")
    newsOPPBTPDetailsViewController.news = news
    navigationController.pushViewController(newsOPPBTPDetailsViewController, animated: true)
  }
}

// MARK: Prevention screen
extension FlowManager {
  static func presentListOfTopicViewController(navigationController: UINavigationController, group: CTGroup) {
    let listOfTopicViewController = CTListOfTopicViewController.instantiateFromStoryboard("Prevention")
    listOfTopicViewController.group = group
    navigationController.pushViewController(listOfTopicViewController, animated: true)
  }
  
  static func presentThematicDetailViewController(navigationController: UINavigationController, theme: CTTheme) {
    let thematicDetailViewController = CTThematicDetailViewController.instantiateFromStoryboard("Prevention")
    thematicDetailViewController.theme = theme
    navigationController.pushViewController(thematicDetailViewController, animated: true)
  }
}

// MARK: Handle when expired token
extension FlowManager {
  static func expiredToken() {
    if let rootViewController = appDelegate.window?.rootViewController {
      let alert = UIAlertController(title: "Alerte", message: "common_expired_token".localized, preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: FlowManager.backToLogin))
      rootViewController.presentViewController(alert, animated: true, completion: nil)
    }
  }
  
  static func backToLogin(alert: UIAlertAction) {
    appDelegate.hideNavigationBarView(true)
    appDelegate.navigationBarView?.userLineV.hidden = false
    appDelegate.navigationController?.popToRootViewControllerAnimated(true)
  }
}

// MARK: Sync data when offline to online
extension FlowManager {
  static func syncData(completion: (()->())? = nil) {
    CTUserLocalAPI.refreshToken(CTUserInformation.sharedInstance.user) { (result) in
      if result == true {
        self.syncOnlineOffline(completion)
      } else {
        completion?()
      }
    }
  }
  
  static func syncOnlineOffline(completion: (()->())? = nil) {
    if let sync = CTSyncLoader.sharedInstance.loadUnsendSync() {
      switch sync.functionName {
      case RESTContants.SiteAdd:
        CTSiteLocalAPI.syncSiteAdd(sync, completion: { 
          self.syncOnlineOffline(completion)
        }, failure: { msg in
          // Alert
          print(msg)
          Utils.scheduleLocalNotification(msg)
        })
        break
      case RESTContants.SiteUpdate:
        CTSiteLocalAPI.syncSiteUpdate(sync, completion: {
          self.syncOnlineOffline(completion)
        }, failure: { msg in
          // Alert
          print(msg)
          Utils.scheduleLocalNotification(msg)
        })
        break
      case RESTContants.SiteCollaboratorAdd:
        CTSiteLocalAPI.syncSiteCollaboratorAdd(sync, completion: {
          self.syncOnlineOffline(completion)
        }, failure: { msg in
          // Alert
          print(msg)
          Utils.scheduleLocalNotification(msg)
        })
        break
      case RESTContants.SiteCollaboratorCreateAndAdd:
        CTSiteLocalAPI.syncSiteCollaboratorCreateAndAdd(sync, completion: {
          self.syncOnlineOffline(completion)
        }, failure: { msg in
          // Alert
          print(msg)
          Utils.scheduleLocalNotification(msg)
        })
        break
      case RESTContants.SiteTallyAdd:
        CTSiteLocalAPI.syncSiteTallyAdd(sync, completion: {
          self.syncOnlineOffline(completion)
        }, failure: { msg in
          // Alert
          print(msg)
          Utils.scheduleLocalNotification(msg)
        })
        break
      case RESTContants.SiteWelcomeAdd:
        CTSiteLocalAPI.syncSiteWelcomeAdd(sync, completion: {
          self.syncOnlineOffline(completion)
        }, failure: { msg in
          // Alert
          print(msg)
          Utils.scheduleLocalNotification(msg)
        })
        break
      case RESTContants.SiteEventAdd:
        CTSiteLocalAPI.syncSiteEventAdd(sync, completion: {
          self.syncOnlineOffline(completion)
        }, failure: { msg in
          // Alert
          print(msg)
          Utils.scheduleLocalNotification(msg)
        })
        break
      default:
        break
      }
    } else {
      completion?()
    }
  }
}