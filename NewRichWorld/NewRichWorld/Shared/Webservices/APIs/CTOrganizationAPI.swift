//
//  CTOrganizationAPI.swift
//  Chantier
//
//  Created by iOS Dev on 8/18/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation

class CTOrganizationAPI: CTBaseAPI {
  
  static func getDocumentCategories(organizationID: Int, completion: (result: [CTOrganisationCategoryDocument]?, error: RESTError?) -> Void) {
    
    let request = RESTRequest(functionName: RESTContants.OrganizationDocumentCategories, method: .GET, endcoding: .URLEncodedInURL)
    
    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
    request.addQueryParam("organizationid", value: organizationID)
    request.baseInvoker { (result, error) in
      completion(result: getList("categories", from: result), error: error)
    }
  }
  
  static func getDocumentDetail(documentId: Int, completion: (result: CTDocument?, error: RESTError?) -> Void) {
    
    let request = RESTRequest(functionName: RESTContants.OrganizationDocumentDetail, method: .GET, endcoding: .URLEncodedInURL)
    
    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
    request.addQueryParam("document_organization_id", value: documentId)
    request.baseInvoker { (result, error) in
      completion(result: getOne(result), error: error)
    }
    
  }
  
  static func getDocumentDetailCategory(documentOrganizationId: Int, completion: (result: [CTOrganisationCategoryDocument]?, error: RESTError?) -> Void) {
    
    let request = RESTRequest(functionName: RESTContants.OrganizationDocumentDetail, method: .GET, endcoding: .URLEncodedInURL)
    
    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
    request.addQueryParam("document_organization_id", value: documentOrganizationId)
    request.baseInvoker { (result, error) in
      completion(result: getList("categories",from: result), error: error)
    }
    
    
  }
  
  
  static func getOrganisationAdviser(organizationID: Int, completion: (result: CTAdviser?, error: RESTError?) -> Void) {
    
    let request = RESTRequest(functionName: RESTContants.OrganizationAdviser, method: .GET, endcoding: .URLEncodedInURL)
    
    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
    request.addQueryParam("organizationid", value: organizationID)
    request.baseInvoker { (result, error) in
      completion(result: getOne(result?["adviser"]), error: error)
    }
    
  }
  
  static func getPreventionCollaborators(organizationID: Int, completion: (result: [CTPrevention]?, error: RESTError?) -> Void) {
    
    let request = RESTRequest(functionName: RESTContants.OrganizationPreventionCollaborators, method: .GET, endcoding: .URLEncodedInURL)
    
    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
    request.addQueryParam("organizationid", value: organizationID)
    request.baseInvoker { (result, error) in
      completion(result: getList("site_collaborators", from: result), error: error)
    }
  }
  
  static func getOrganizationCollaborators(organizationID: Int, completion: (result: [CTCollborator]?, error: RESTError?) -> Void) {
    let request = RESTRequest(functionName: RESTContants.OrganizationCollaborator, method: .GET, endcoding: .URLEncodedInURL)
    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
    request.addQueryParam("organizationid", value: organizationID)
    request.baseInvoker { (result, error) in
      completion(result: getList("site_collaborators", from: result), error: error)
    }
  }
  static func getNewsList(organizationID: Int, completion: (result: [CTNews]?, error: RESTError?) -> Void) {
    
    let request = RESTRequest(functionName: RESTContants.OrganizationNewsList, method: .GET, endcoding: .URLEncodedInURL)
    
    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
    request.addQueryParam("organizationid", value: organizationID)
    request.baseInvoker { (result, error) in
      completion(result: getList("news", from: result), error: error)
    }
    
  }
  
  
  static func getOrganizationNewsLast(organizationID: Int, completion: (result: [CTNews]?, error: RESTError?) -> Void) {
    
    let request = RESTRequest(functionName: RESTContants.OrganizationNewsLast, method: .GET, endcoding: .URLEncodedInURL)
    
    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
    request.addQueryParam("organizationid", value: organizationID)
    request.baseInvoker { (result, error) in
      completion(result: getList("last_news", from: result), error: error)
    }
    
  }
  
  static func getNews(organizationID: Int, newsID: Int, completion: (result: CTNews?, error: RESTError?) -> Void) {
    
    let request = RESTRequest(functionName: RESTContants.OrganizationNews, method: .GET, endcoding: .URLEncodedInURL)
    
    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
    request.addQueryParam("newsid", value: newsID)
    request.baseInvoker { (result, error) in
      // CHA-159
      completion(result: getOne(result?[0]), error: error)
    }
    
  }
  
  static func getSites(organizationID: Int, completion: (result: [CTSite]?, error: RESTError?) -> Void) {
    
    let request = RESTRequest(functionName: RESTContants.OrganizationSites, method: .GET, endcoding: .URLEncodedInURL)
    
    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
    request.addQueryParam("organizationid", value: organizationID)
    request.baseInvoker { (result, error) in
      completion(result: getList("organization_sites", from: result), error: error)
    }
  }
  
  static func getOrganisationNotification (completion: (result: [CTNotification]?, error: RESTError?) -> Void) {
    let request = RESTRequest(functionName: RESTContants.OrganizationNotifications, method: .GET, endcoding: .URLEncodedInURL)
    
    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
//    request.addQueryParam("organizationid", value: organizationID)
    request.baseInvoker { (result, error) in
      completion(result: getList("organization_notifications", from: result), error: error)
    }
  }
}
