//
//  CTOppAPI.swift
//  Chantier
//
//  Created by iOS Dev on 8/18/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation

class CTOppAPI: CTBaseAPI {
  
  static func getGroupDocumentation(completion: (result: [CTGroup]?, error: RESTError?) -> Void) {
    
    let request = RESTRequest(functionName: RESTContants.OPPGroupDocumentation, method: .GET, endcoding: .URLEncodedInURL)
    
    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
    request.baseInvoker { (result, error) in
      completion(result: getList("groups", from: result), error: error)
    }
    
  }
  
  static func getThemesOfGroup(groupID: Int, completion: (result: [CTTheme]?, error: RESTError?) -> Void) {
    
    let request = RESTRequest(functionName: RESTContants.OPPPreventionThematics, method: .GET, endcoding: .URLEncodedInURL)
    
    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
    request.addQueryParam("group_id", value: groupID)
    request.baseInvoker { (result, error) in
      completion(result: getList("themes", from: result), error: error)
    }
    
  }
  
  static func getDocumentListOfTheme(themeDocumentID: Int, completion: (result: [CTDocument]?, error: RESTError?) -> Void) {
    
    let request = RESTRequest(functionName: RESTContants.OPPPreventionDocument, method: .GET, endcoding: .URLEncodedInURL)
    
    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
    request.addQueryParam("theme_document_id", value: themeDocumentID)
    request.baseInvoker { (result, error) in
      completion(result: getList("documents", from: result), error: error)
    }
    
  }
  
  static func getPreventionContentsLast(completion: (result: [CTPreventionContentsLast]?, error: RESTError?) -> Void) {
    
    let request = RESTRequest(functionName: RESTContants.OPPPreventionContentsLast, method: .GET, endcoding: .URLEncodedInURL)
    
    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
    request.baseInvoker { (result, error) in
      completion(result: getList("documents", from: result), error: error)
    }
  }
  
  static func getNews(completion: (result: [CTNews]?, error: RESTError?) -> Void) {
    
    let request = RESTRequest(functionName: RESTContants.OPPNews, method: .GET, endcoding: .URLEncodedInURL)
    
    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
    request.baseInvoker { (result, error) in
      completion(result: getList("news", from: result), error: error)
    }
    
  }
  
  static func getNew(newsID: Int, completion: (result: CTNews?, error: RESTError?) -> Void) {
    
    let request = RESTRequest(functionName: RESTContants.OPPNew, method: .GET, endcoding: .URLEncodedInURL)
    
    request.setAuthorization(CTUserInformation.sharedInstance.user.token)
    request.addQueryParam("newsid", value: newsID)
    request.baseInvoker { (result, error) in
      completion(result: getOne(result?[0]), error: error)
    }
    
  }
}