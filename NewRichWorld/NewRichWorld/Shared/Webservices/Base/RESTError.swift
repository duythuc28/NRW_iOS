//
//  RESTError.swift
//  9Gags
//
//  Created by iOs_Dev on 1/8/16.
//  Copyright © 2016 Duong Tran. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper
import Alamofire

class RESTError: RESTResponse {
  
  convenience required init?(_ map: Map) {
    self.init()
  }
  
  static func parseError(response: Response<AnyObject, NSError>) -> RESTError {
    let restError = RESTError()
    
    if let message = response.result.value, let statusCode = response.response?.statusCode {
      restError.message = message as? String ?? ""
      restError.statusCode = statusCode
    }
    
    return restError
  }
  
}
