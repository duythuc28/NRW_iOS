//
//  FlowTagging.swift
//  Chantier
//
//  Created by Hung Thai on 10/19/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation
import FirebaseAnalytics

final class FlowTagging {
  // TagScreen Keys
  private static let login = "login_screen"
  private static let forgotPassword = "forgot_password_screen"
  private static let home = "home_screen"
  private static let constructionSite = "construction_site_screen"
  private static let businessNews = "business_news_screen"
  private static let businessNewsDetail = "business_news_detail_screen"
  private static let constructionDocument = "construction_document_screen"
  private static let pointerStaff = "pointer_staff_screen"
  private static let welcomeToSite = "welcome_to_site_screen"
  private static let events = "event_screen"
  private static let reportAnEvent = "report_an_event_screen"
  private static let corporateDocument = "corporate_document_screen"
  private static let listOfDocumentCategories = "document_category_screen"
  private static let OPPBTPNews = "oppbtp_news_screen"
  private static let OPPBTPNewsDetail = "oppbtp_news_detail_screen"
  private static let preventionInformation = "prevention_information_screen"
  private static let listOfTopics = "topics_screen"
  private static let thematicDetail = "thematic_detail_screen"
  private static let legalNotice = "legal_screen"
  private static let about = "about_screen"
  private static let accident = "accident_screen"
  private static let profile = "profile_screen"
  private static let settings = "settings_screen"
  private static let createSite = "create_site_screen"
  
  // TagEvent Keys
  private static let createSiteEvent = "add_site_event"
  private static let updateSiteEvent = "update_site_event"
  private static let addCollaboratorEvent = "add_collaborator_event"
  private static let collaboratorTallyEvent = "add_tally_event"
  private static let addEventEvent = "add_event_event"
  private static let addWelcomeEvent = "add_welcome_event"
  /**
   Login Screen
   */
  static func loginScreen() {
    print(self.login)
    FIRAnalytics.logEventWithName(self.login, parameters: [
      "user": "Chantier"
    ])
    
    
  }
  
  /**
   ForgotPassword Screen
   */
  static func forgotPasswordScreen() {
    print(self.forgotPassword)
    FIRAnalytics.logEventWithName(self.forgotPassword, parameters: [
      "user": "Chantier"
      ])
  }
  
  // MARK: Home Screen
  /**
   Home screen
   */
  static func homeScreen() {
    print(self.home)
    FIRAnalytics.logEventWithName(self.home, parameters: [
     "user": "Chantier"
      ])
  }
  
  // MARK: Create Site Screen
  static func createSiteScreen() {
    print(self.createSite)
    FIRAnalytics.logEventWithName(self.createSite, parameters: [
      "user": "Chantier"
      ])
  }
  
  // MARK: Create Site Action
  static func createSiteAction() {
    print(self.createSiteEvent)
//    FIRAnalytics.logEventWithName(self.createSiteEvent, parameters: [
//     "user": "Chantier"
//      ])
  }
  
  static func updateSiteAction() {
    print(self.updateSiteEvent)
//    FIRAnalytics.logEventWithName(self.updateSiteEvent, parameters: [
//      "user": "Chantier"
//      ])
  }
  
  // MARK: Construction Site Screen
  static func constructionSiteScreen() {
    print(self.constructionSite)
    FIRAnalytics.logEventWithName(self.constructionSite, parameters: [
      "user": "Chantier"
      ])
  }
  
  // MARK: Welcome To Site Screen
  static func welcomeToSiteScreen() {
    print(self.welcomeToSite)
    FIRAnalytics.logEventWithName(self.welcomeToSite, parameters: [
      "user": "Chantier"
      ])
  }
  
  // MARK: Welcome To Site Action
  static func welcomeToSiteAction() {
    print(self.addWelcomeEvent)
//    FIRAnalytics.logEventWithName(self.addWelcomeEvent, parameters: [
//      "user": "Chantier"
//      ])
  }
  
  // MARK: Pointer Staff Screen
  static func pointerStaffScreen() {
    print(self.pointerStaff)
    FIRAnalytics.logEventWithName(self.pointerStaff, parameters: [
      "user": "Chantier"
      ])
  }
  
  // MARK: Events screen
  static func eventsScreen() {
    print(self.events)
    FIRAnalytics.logEventWithName(self.events, parameters: [
      "user": "Chantier"
      ])
  }
  
  // MARK: Report An Event Screen
  static func reportAnEventScreen() {
   print(self.reportAnEvent)
    FIRAnalytics.logEventWithName(self.reportAnEvent, parameters: [
      "user": "Chantier"
      ])
  }
  
  // MARK: Report An Event Action
  static func reportAnEventAction() {
    print(self.addEventEvent)
//    FIRAnalytics.logEventWithName(self.addEventEvent, parameters: [
//      "user": "Chantier"
//      ])
  }
  
  // MARK: Construction Document Screen
  static func constructionDocumentScreen() {
    print(self.constructionDocument)
    FIRAnalytics.logEventWithName(self.constructionDocument, parameters: [
      "user": "Chantier"
      ])
  }
  
  // MARK: Business News
  static func businessNewsScreen() {
    print(self.businessNews)
    FIRAnalytics.logEventWithName(self.businessNews, parameters: [
      "user": "Chantier"
      ])
  }
  
  // MARK: BusinessNews Detail Screen
  static func businessNewsDetailScreen() {
    print(self.businessNewsDetail)
    FIRAnalytics.logEventWithName(self.businessNewsDetail, parameters: [
      "user": "Chantier"
      ])
  }
  
  // MARK: OPPBTP News Screen
  static func oppbtpNewsScreen() {
    print(self.OPPBTPNews)
    FIRAnalytics.logEventWithName(self.OPPBTPNews, parameters: [
      "user": "Chantier"
      ])
  }
  
  // MARK: OPPBTP News Detail Screen
  static func oppbtpNewsDetailScreen() {
    print(self.OPPBTPNewsDetail)
    FIRAnalytics.logEventWithName(self.OPPBTPNewsDetail, parameters: [
      "user": "Chantier"
      ])
  }
  
  // MARK: Corporate Document Screen
  static func corporateDocumentScreen() {
    print(self.corporateDocument)
    FIRAnalytics.logEventWithName(self.corporateDocument, parameters: [
      "user": "Chantier"
      ])
  }
  
  // MARK: List Of Document CategoriesScreen
  static func listOfDocumentCategoriesScreen() {
    print(self.listOfDocumentCategories)
    FIRAnalytics.logEventWithName(self.listOfDocumentCategories, parameters: [
      "user": "Chantier"
      ])
  }
  
  // MARK: Prevention Information Screen
  static func preventionInformationScreen() {
    print(self.preventionInformation)
    FIRAnalytics.logEventWithName(self.preventionInformation, parameters: [
      "user": "Chantier"
      ])
  }
  
  static func listOfTopicsScreen() {
    print(self.listOfTopics)
    FIRAnalytics.logEventWithName(self.listOfTopics, parameters: [
      "user": "Chantier"
      ])
  }
  
  static func thematicDetailScreen() {
    print(self.thematicDetail)
    FIRAnalytics.logEventWithName(self.thematicDetail, parameters: [
      "user": "Chantier"
      ])
  }
  
  // MARK: NavigationBar
  static func accidentScreen() {
    print(self.accident)
    FIRAnalytics.logEventWithName(self.accident, parameters: [
      "user": "Chantier"
      ])
  }
  
  static func settingScreen() {
   print(self.settings)
    FIRAnalytics.logEventWithName(self.settings, parameters: [
      "user": "Chantier"
      ])
  }
  
  static func profileScreen() {
    print(self.profile)
    FIRAnalytics.logEventWithName(self.profile, parameters: [
      "user": "Chantier"
      ])
  }
  
  static func legalNoticeScreen() {
    print(self.legalNotice)
    FIRAnalytics.logEventWithName(self.legalNotice, parameters: [
      "user": "Chantier"
      ])
  }
  
  static func aboutScreen() {
    print(self.about)
    FIRAnalytics.logEventWithName(self.about, parameters: [
      "user": "Chantier"
      ])
  }
  
  // MARK: Collaborator actions
  static func addCollaboratorAction() {
    print(self.addCollaboratorEvent)
//    FIRAnalytics.logEventWithName(self.addCollaboratorEvent, parameters: [
//      "user": "Chantier"
//      ])
  }
  
  static func collaboratorTallyAction() {
    print(self.collaboratorTallyEvent)
//    FIRAnalytics.logEventWithName(self.collaboratorTallyEvent, parameters: [
//      "user": "Chantier"
//      ])
  }
}