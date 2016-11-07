//
//  CTSiteAPI.swift
//  Chantier
//
//  Created by iOS Dev on 8/18/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation

class CTSiteAPI: CTBaseAPI {
  
  static func getActivities(siteID: Int, completion: (result: [CTActivity]?, error: RESTError?) -> Void) {

    let request = RESTRequest(functionName: RESTContants.SiteActivities, method: .GET, endcoding: .URLEncodedInURL)

    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
    request.addQueryParam("siteid", value: siteID)
    request.baseInvoker { (result, error) in
      completion(result: getList("activities", from: result), error: error)
    }
    
  }

  static func getDocuments(siteID: Int, completion: (result: [CTDocument]?, error: RESTError?) -> Void) {

    let request = RESTRequest(functionName: RESTContants.SiteDocuments, method: .GET, endcoding: .URLEncodedInURL)

    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
    request.addQueryParam("siteid", value: siteID)
    request.baseInvoker { (result, error) in
      completion(result: getList("site_documents", from: result), error: error)
    }
    
  }
  
  static func getDocument(siteID: Int, documentID: Int, completion: (result: CTDocument?, error: RESTError?) -> Void) {
    
    let request = RESTRequest(functionName: RESTContants.SiteDocument, method: .GET, endcoding: .URLEncodedInURL)
    
    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
    request.addQueryParam("site_id", value: siteID)
    request.addQueryParam("document_id", value: documentID)
    request.baseInvoker { (result, error) in
        completion(result: getOne(result), error: error)
    }
    
  }
  
  static func getCollaborators(siteID: Int, completion: (result: [CTSiteCollaborator]?, error: RESTError?) -> Void) {
    
    let request = RESTRequest(functionName: RESTContants.SiteCollaborators, method: .GET, endcoding: .URLEncodedInURL)
    
    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
    request.addQueryParam("siteid", value: siteID)
    request.baseInvoker { (result, error) in
      completion(result: getList("site_collaborators", from: result), error: error)
    }
    
  }
  
  static func getTally(siteID: Int, completion: (result: [CTTally]?, error: RESTError?) -> Void) {
    
    let request = RESTRequest(functionName: RESTContants.SiteTally, method: .GET, endcoding: .URLEncodedInURL)
    
    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
    request.addQueryParam("siteid", value: siteID)
    request.baseInvoker { (result, error) in
      completion(result: getList("site_tallies", from: result), error: error)
    }
    
  }
  
  static func postAdd(params: CTSiteAddParams, completion: (result: Int?, error: RESTError?) -> Void) {
    let request = RESTRequest(functionName: RESTContants.SiteAdd, method: .POST, endcoding: .URL)
    
    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
    request.setQueryParam(params)
    request.addHeader(RESTContants.RequestContentTypeKey, value: "application/x-www-form-urlencoded")
    request.baseInvoker { (result, error) in
      completion(result: result?["site_id"] as? Int, error: error)
    }
    
  }
  
  static func putUpdate(params: CTSiteUpdateParams, completion: (result: String?, error: RESTError?) -> Void) {
    let functionName = "\(RESTContants.SiteUpdate)/\(params.siteID)"
    
    let request = RESTRequest(functionName: functionName, method: .POST /*.PUT*/, endcoding: .URL)
    
    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
    request.setQueryParam(params)
    request.addHeader(RESTContants.RequestContentTypeKey, value: "multipart/form-data")
    request.baseUpload { (result, error) in
      completion(result: result as? String, error: error)
    }
  }
  
  static func getEvents(siteID: Int, completion: (result: [CTEvent]?, error: RESTError?) -> Void) {
    
    let request = RESTRequest(functionName: RESTContants.SiteEvents, method: .GET, endcoding: .URLEncodedInURL)
    
    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
    request.addQueryParam("siteid", value: siteID)
    request.baseInvoker { (result, error) in
      completion(result: getList("events", from: result), error: error)
    }
  }
  
  static func getEventTypes(completion: (result: [CTEventType]?, error: RESTError?) -> Void) {
    let request = RESTRequest(functionName: RESTContants.SiteEventType, method: .GET, endcoding: .URLEncodedInURL)
    
    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
    request.baseInvoker{ (result, error) in
      completion(result: getList("event_types", from: result), error: error)
    }
  }
  
  static func postCollaboratorAdd(params: CTCollaboratorAddParams, completion: (result: CTCollaboratorAdd?, error: RESTError?) -> Void) {
    
    let request = RESTRequest(functionName: RESTContants.SiteCollaboratorAdd, method: .POST, endcoding: .URL)
    
    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
    request.setQueryParam(params)
    request.addHeader(RESTContants.RequestContentTypeKey, value: "application/x-www-form-urlencoded")
    request.baseInvoker{ (result, error) in
      completion(result: getOne(result), error: error)
    }
    
  }
  
  static func postEventAdd(params: CTEventAddParams, completion: (result: Int?, error: RESTError?) -> Void) {
    
    let request = RESTRequest(functionName: RESTContants.SiteEventAdd, method: .POST, endcoding: .URL)
    
    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
    request.setQueryParam(params)
    request.addHeader(RESTContants.RequestContentTypeKey, value: "multipart/form-data")
    request.baseUpload { (result, error) in
      completion(result: result?["event_id"] as? Int, error: error)
    }
    
  }
  
  static func postCollaboratorCreateAndAdd(params: CTCollaboratorCreateAndAddParams, completion: (result: Int?, error: RESTError?) -> Void) {
    
    let request = RESTRequest(functionName: RESTContants.SiteCollaboratorCreateAndAdd, method: .POST, endcoding: .URL)
    
    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
    request.setQueryParam(params)
    request.addHeader(RESTContants.RequestContentTypeKey, value: "multipart/form-data")
    request.baseUpload{ (result, error) in
      completion(result: result?["collaborator_id"] as? Int, error: error)
    }
    
  }
  
  static func postWelcomeAdd(params: CTWelcomeAddParams, completion: (result: Int?, error: RESTError?) -> Void) {
    
    let request = RESTRequest(functionName: RESTContants.SiteWelcomeAdd, method: .POST, endcoding: .URL)
    
    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
    request.setQueryParam(params)
    request.addHeader(RESTContants.RequestContentTypeKey, value: "multipart/form-data")
    request.baseUpload { (result, error) in
      completion(result: result?["welcome_id"] as? Int, error: error)
    }
    
  }
  
  static func postTallyAdd(params: CTTallyAddParams, completion: (result: [Int]?, error: RESTError?) -> Void) {
    
    let request = RESTRequest(functionName: RESTContants.SiteTallyAdd, method: .POST, endcoding: .JSON)
    
    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
    request.setQueryParam(params)
    request.addHeader(RESTContants.RequestContentTypeKey, value: "application/json")
    request.baseInvoker { (result, error) in
      completion(result: result?["tallies_id"] as? [Int], error: error)
    }
    
  }
}