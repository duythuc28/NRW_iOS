
import UIKit
import Alamofire
import ObjectMapper
import RealmSwift
import SwiftyJSON

class DLLoginAPI: NSObject {
  
  static func login(params: DLLoginParams, completion: (result: DLUserInfo?, error: RESTError?) -> Void) {
    
    let request = RESTRequest(functionName: RESTContants.Login, method: .POST, endcoding: .JSON)
    
    request.setQueryParam(params)
    request.baseInvoker { (result, error) in
      if error == nil {
        completion(result: Mapper<DLUserInfo>().map(result), error: nil)
      } else {
        completion(result: nil, error: error)
      }
    }
  }
  
  static func getUserProfile(accountID accountID: String, completion: (result: DLUserInfo?, error: RESTError?) -> Void) {
    let request = RESTRequest(functionName: RESTContants.GetUserProfile, method: .POST, endcoding: .JSON)
    
    request.addQueryParam("account_id", value: accountID)
    request.baseInvoker { (result, error) in
      if error == nil {
        completion(result: Mapper<DLUserInfo>().map(result), error: nil)
      } else {
        completion(result: nil, error: error)
      }
    }
  }
  
  static func updateUserProfile(params: DLUpdateProfileParams, completion: (result: AnyObject?, error: RESTError?) -> Void) {
    let request = RESTRequest(functionName: RESTContants.UpdateUserProfile, method: .POST, endcoding: .JSON)
    
    request.setQueryParam(params)
    request.baseUpload { (result, error) in
      if error == nil {
        completion(result: result, error: nil)
      } else {
        completion(result: nil, error: error)
      }
    }

  }
}
