//
//  CTDummyAPI.swift
//  Chantier
//
//  Created by iOS Dev on 8/15/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import RealmSwift
import SwiftyJSON

class CTDummyAPI: NSObject {
  
  static let sharedInstance = CTDummyAPI()
  let userTypeLoader = CTUserTypeLoader.sharedInstance
  let roleLoader = CTRoleLoader.sharedInstance
  let userLoader = CTUserLoader.sharedInstance
  let organisationLoader = CTOrganisationLoader.sharedInstance
  let newsLoader = CTNewsLoader.sharedInstance
  
  func initDatabase() {
    if userTypeLoader.load().count == 0 {
      self.createUserType()
    }

    if roleLoader.load().count == 0 {
      self.createRole()
    }
    
//    if userLoader.load().count == 0 {
//      self.createUser()
//    }
    
//    if organisationLoader.load().count == 0 {
//      userLoader.validateUser("user@gmail.com", password: "123abc")
//      self.createOrganisation()
//    }
//    
//    if CTSiteLoader.sharedInstance.load().count == 0 {
//      self.createSite()
//    }
    
//    if CTNewsLoader.sharedInstance.load().count == 0 {
//      self.createNews()
//      self.createNewsWithOrganization()
//    }
//    CTUserInformation.sharedInstance.user = userLoader.query("username = 'abc@gmail.com'").first as! CTUser
    
//    FlowManager.loadDataAfterLogin {
//      print("OKOKOKO")
//    }
//      let user = CTUserInformation.sharedInstance.user
//      if let role = self.roleLoader.query("name = 'user'").first as? CTRole {
//        self.userLoader.beginWrite()
//        user.role = role
//        self.userLoader.commitWrite()
//      }
    
//    CTUserAPI.getListOrganizations { (result, error) in
//      for item in result! {
//        print(item.name)
//        print(item.logo)
//        print(item.remoteId)
//        print(item.id)
//      }
//    }
//    CTSiteAPI.postWelcomeAdd(CTWelcomeAddParams(), completion: { (result, error) in
//      print(result)
//      print(error)
//    })
//    CTOppAPI.getPreventionThematics(701484, completion: { (result, error) in
//      for item in result! {
//        print(item.remoteId)
//      }
//    })
    
//    let param = CTSiteAddParams.init(organizationID: 347, siteID: 347, name: "NAME", reference: "REFERENCE", dateStart: NSDate(), address: "address", zipcode: "zipcode")
//    CTSiteAPI.getAdd(param) { (result, error) in
//      
//    }
    
//    CTOrganizationLocalAPI.getSites(0) { (result) in
//      print(result!.count)
//    }
  }
  
  func createUserType() {
    let types = ["constructor", "collaborator", "adviser"]

    types.forEach { (type) in
      let userType = CTUserType()
      userType.typeName = type
      userTypeLoader.addUserType(userType)
    }
  }
  
  func createRole() {
    let role = CTRole()
    role.name = "user"
    roleLoader.addRole(role)
  }
  
  func createUser() {
      let data = [["123abc", "SUTRIX", "user@gmail.com",  "OAuth 5cf8b30fa5b9773df7dc8388a44d3941a80caa3d"],
                  ["123456", "SUTRIX", "abc@gmail.com",  "OAuth 5cf8b30fa5b9773df7dc8388a44d3941a80caa3d"]]
    
      data.forEach { (item) in
        CTUserLoader.sharedInstance.updateOrAdd(item[2], password: item[0], userInfo: nil)
      }
  }
  
  func createOrganisation() {
    let data = [["Organ 01", "", "01254854544",  "Advice 01"],
                ["Organ 02", "", "0984654542",  "Advice 02"],
                ["Organ 03", "", "0303030303",  "Advice 03"],
                ["Organ 04", "", "0404040404",  "Advice 04"]]
    
    let collaborators = [["Steve", "Job1", NSDate(), 1], ["Steve", "Job2", NSDate(), 2], ["Steve", "Job3", NSDate(), 3]]
    
    
    // Create a organisation
    data.forEach { (item) in
      let organ = CTOrganisation()
      organ.name = item[0]
      organ.logo = item[1]
      organ.emergencyPhone = item[2]
      organ.emergencyAdvice = item[3]
      
      organisationLoader.addOrganisation(organ, owner: CTUserInformation.sharedInstance.user)
    }
    
    // Add collaborators to organisation
    for item in organisationLoader.load() {
      for collaborator in collaborators {
        let firstName = collaborator[0] as! String
        let lastName = collaborator[1] as! String
        let birthDay = collaborator[2] as! NSDate
        let remoteId = collaborator[3] as! Int
        let localId = userLoader.addCollaborator(firstName, lastName: lastName, birthday: birthDay, photo: "", organisation: item as! CTOrganisation)
        userLoader.updateCollaborator(localId, remoteId: remoteId)
      }
    }
  }
  
  func createSite() {
    let site = CTSite()
    site.name = "Chantier 01"
    site.remoteId = 50
    site.address1 = "13 Dong Khoi"
    site.address1 = "Sai Gon"
    site.country = "Viet Nam"
    site.organisation = CTOrganisationLoader.sharedInstance.query("name = 'Organ 02'").first as? CTOrganisation
    
    CTSiteLoader.sharedInstance.addSite(site)
    
    CTUserLoader.sharedInstance.beginWrite()
    for collaborator in site.organisation!.users {
      collaborator.sites.append(site)
    }
    CTUserLoader.sharedInstance.commitWrite()
  }
  
  func createNews() {
    
    let data = [["News 01", "Introduce 01", "Body content business news 01, Body content business news 01, Body content business news 01...."],
                ["News 02", "Introduce 02", "Body content business news 02, Body content business news 02, Body content businesss news 02..."],
                ["News 03", "Introduce 03", "Body content business news 03, Body content business news 03, Body content businesss news 03..."],
                ["News 04", "Introduce 04", "Body content business news 04, Body content business news 04, Body content businesss news 04..."],
                ["News 05", "Introduce 05", "Body content business news 05, Body content business news 05, Body content businesss news 05..."],
                ["News 06", "Introduce 06", "Body content business news 06, Body content business news 06, Body content businesss news 06..."],
                ["News 07", "Introduce 07", "Body content business news 07, Body content business news 07, Body content businesss news 07..."],
                ["News 08", "Introduce 08", "Body content business news 08, Body content business news 08, Body content businesss news 08..."],
                ["News 09", "Introduce 09", "Body content business news 09, Body content business news 09, Body content businesss news 09..."],
                ["News 10", "Introduce 10", "Body content business news 10, Body content business news 10, Body content businesss news 10..."]]
  
    data.forEach{ (item) in
      let news = CTNews()
      news.name = item[0]
      news.intro = item[1]
      news.body = item[2]
     
      newsLoader.addNews(news)
    }
  }
  
  func createNewsWithOrganization() {
  
    let data = [["News 01", "Introduce 01", "Body content business news 01 Organ 02, Body content business news 01, Body content business news 01 Organ 02...."],
                ["News 02", "Introduce 02", "Body content business news 02 Organ 02, Body content business news 02, Body content businesss news 02 Organ 02..."],
                ["News 03", "Introduce 03", "Body content business news 03 Organ 02, Body content business news 03, Body content businesss news 03 Organ 02..."],
                ["News 04", "Introduce 04", "Body content business news 04 Organ 02, Body content business news 04, Body content businesss news 04 Organ 02..."],
                ["News 05", "Introduce 05", "Body content business news 05 Organ 02, Body content business news 05, Body content businesss news 05 Organ 02..."],
                ["News 06", "Introduce 06", "Body content business news 06 Organ 02, Body content business news 06, Body content businesss news 06 Organ 02..."],
                ["News 07", "Introduce 07", "Body content business news 07 Organ 02, Body content business news 07, Body content businesss news 07 Organ 02..."],
                ["News 08", "Introduce 08", "Body content business news 08 Organ 02, Body content business news 08, Body content businesss news 08 Organ 02..."],
                ["News 09", "Introduce 09", "Body content business news 09 Organ 02, Body content business news 09, Body content businesss news 09 Organ 02..."],
                ["News 10", "Introduce 10", "Body content business news 10 Organ 02, Body content business news 10, Body content businesss news 10 Organ 02..."]]
    
    data.forEach { (item) in
      let news = CTNews()
      news.name = item[0]
      news.intro = item[1]
      news.body = item[2]
      
      let organisation = CTOrganisationLoader.sharedInstance.query("name = 'Organ 02'").first as? CTOrganisation
      news.organisation = organisation
      
      newsLoader.addNews(news)
    }
  }

}