 //
//  CTUserApi.swift
//  Chantier
//
//  Created by iOS Dev on 8/17/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation
import Firebase
 
class CTUserAPI: CTBaseAPI {
  
  static func getListOrganizations(completion: (result: [CTOrganisation]?, error: RESTError?) -> Void) {
    
    let request = RESTRequest(functionName: RESTContants.UserOrganizations, method: .GET, endcoding: .URLEncodedInURL)
    
    request.setAuthorization(CTUserInformation.sharedInstance.token)
    request.baseInvoker { (result, error) in
      completion(result: getList("organizations", from: result), error: error)
    }
  }
  
  static func login(username: String, password: String, completion: (result: CTUserLogin?, error: RESTError?) -> Void) {
    
    let request = RESTRequest(functionName: RESTContants.Login, method: .POST, endcoding: .URL)
    
    request.addQueryParam("login", value: username)
    request.addQueryParam("password", value: password)
    request.addQueryParam("client_id", value: "6fd4604d9501c0eb13b5c68a85a82e75")
    if let refreshedToken = FIRInstanceID.instanceID().token() {
      request.addQueryParam("device_id", value: refreshedToken)
    }
    request.loginInvoker { (result, error) in
      completion(result: getOne(result), error: error)
    }
  }
  
  static func forgotPassword(email: String, completion: (result: String?, error: RESTError?) -> Void) {
    
    let request = RESTRequest(functionName: RESTContants.ForgotPassword, method: .GET, endcoding: .URL)
    
    request.addQueryParam("email", value: email)
    request.forgotPasswordInvoker { (result, error) in
      completion(result: result?["success"] as? String, error: error)
    }
  }
}
