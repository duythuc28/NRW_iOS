

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

typealias RestAPICompletion = (result: AnyObject?, error: RESTError?) -> Void
typealias RestDownloadProgress = (bytesRead : Int64, totalBytesRead : Int64, totalBytesExpectedToRead : Int64) -> Void

class RESTRequest: NSObject {
  
  var baseUrl: String = ""
  var parameters: [String: AnyObject] = [:]
  var headers: [String: String] = RESTContants.Headers as! [String : String]
  var multiparts = NSMutableArray()
  var requestMethod: Alamofire.Method = .GET
  var endcoding: ParameterEncoding = .URL
  
  //MARK: Base
  init(url: String, functionName: String, method: Alamofire.Method, endcoding: ParameterEncoding) {
    super.init()
    self.handleInit(url + functionName, method: method, endcoding: endcoding)
  }
  
  init(functionName: String, method: Alamofire.Method, endcoding: ParameterEncoding) {
    super.init()
    self.handleInit(RESTContants.WebserviceUrl + functionName, method: method, endcoding: endcoding)
  }
  
  func handleInit(baseUrl: String, method: Alamofire.Method, endcoding: ParameterEncoding) {
    self.baseUrl = baseUrl
    self.endcoding = endcoding
    self.requestMethod = method
  }
  
  //MARK: Properties
  func setQueryParam(param: RESTParam) {
    parameters = param.toDictionary()
  }
  
  func addQueryParam(name: String, value: AnyObject?) {
    if let dataValue = value as? NSData {
      parameters[name] = dataValue
    } else {
      parameters[name] = value
    }
  }
  
  func addHeader(name: String, value: AnyObject?) {
    headers[name] = value as? String
  }
  
  func setContentType(contentType: String) {
    headers[RESTContants.RequestContentTypeKey] = contentType
  }
  
  func setAccept(accept: String) {
    headers[RESTContants.RequestAcceptKey] = accept
  }
  
  func setAuthorization(authorization: String) {
    headers[RESTContants.RequestAuthorizationKey] = authorization
  }
  
  func addPartJson(name: String, model: NSObject) {
    let part = RESTMultipart.JSONPart(name: name, jsonObject: model)
    self.multiparts.addObject(part)
  }
  
  func addPartFile(name: String, fileName: String, data: NSData) {
    let part = RESTMultipart.FilePart(name: name, fileName: fileName, data: data)
    self.multiparts.addObject(part)
  }
  
  //MARK: Alamofire functions
  func baseInvoker(completion: RestAPICompletion) {
    Alamofire.Manager.sharedInstance.request(self.requestMethod, self.baseUrl, parameters: self.parameters, encoding: self.endcoding, headers: self.headers).responseJSON { (response) -> Void in
      self.handleResponse(response, completion: completion)
    }
  }
  
  func loginInvoker(completion: RestAPICompletion) {
    Alamofire.Manager.sharedInstance.request(self.requestMethod, RESTContants.Login, parameters: self.parameters, encoding: self.endcoding, headers: self.headers).responseJSON { (response) -> Void in
      
      if response.response?.statusCode == RESTContants.StatusCodeSuccess
        || response.response?.statusCode == RESTContants.StatusCodeLogin {
        completion(result: response.result.value, error: nil)
      } else {
        completion(result: nil, error: RESTError.parseError(response))
      }
    }
  }
  
  func forgotPasswordInvoker(completion: RestAPICompletion) {
    Alamofire.Manager.sharedInstance.request(self.requestMethod, RESTContants.ForgotPassword, parameters: self.parameters, encoding: self.endcoding, headers: self.headers).responseJSON { (response) -> Void in
      self.handleResponse(response, completion: completion)
    }
  }
  
  func baseUpload(completion: RestAPICompletion) {
    Alamofire.Manager.sharedInstance.upload(self.requestMethod, self.baseUrl, headers: self.headers, multipartFormData: { multipartFormData in
      for (key, value) in self.parameters {
        if let dataValues = value as? [NSData] {
          for dataValue in dataValues {
            multipartFormData.appendBodyPart(data: dataValue, name: key, fileName: "\(NSDate().timeIntervalSince1970).\(self.imageType(dataValue))", mimeType: "image/\(self.imageType(dataValue))")
          }
        } else if let dataValue = value as? NSData {
          multipartFormData.appendBodyPart(data: dataValue, name: key, fileName: "\(NSDate().timeIntervalSince1970).\(self.imageType(dataValue))", mimeType: "image/\(self.imageType(dataValue))")
        } else if let dataValues = value as? [Int] {
          for dataValue in dataValues {
            multipartFormData.appendBodyPart(data: "\(dataValue)".dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
          }
        } else {
          let stringValue = String(value)
          multipartFormData.appendBodyPart(data: stringValue.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
        }
      }
      }, encodingMemoryThreshold: Manager.MultipartFormDataEncodingMemoryThreshold,
         encodingCompletion: { encodingResult in
          switch encodingResult {
          case .Success(let result, _, _):
            result.responseJSON(completionHandler: { response in
              self.handleResponse(response, completion: completion)
            })
          case .Failure(let encodingError):
            print(encodingError)
          }
    })
  }
  
  func handleResponse(response: Response<AnyObject, NSError>, completion: RestAPICompletion) {    
    if response.response?.statusCode == RESTContants.StatusCodeSuccess
      || response.response?.statusCode == RESTContants.StatusCodeLogin
      || response.response?.statusCode == RESTContants.StatusCodeAdded {
      completion(result: response.result.value, error: nil)
    } else {
      if response.response?.statusCode == RESTContants.Unathorizated
      || response.response?.statusCode == RESTContants.MethodNotAllowed {
        FlowManager.expiredToken()
      }
      completion(result: nil, error: RESTError.parseError(response))
    }
  }
  
  func imageType(imgData : NSData) -> String {
    var c = [UInt8](count: 1, repeatedValue: 0)
    imgData.getBytes(&c, length: 1)
    
    let ext : String
    
    switch (c[0]) {
    case 0xFF: ext = "jpg"
      
    case 0x89: ext = "png"
      
    case 0x47: ext = "gif"
      
    case 0x49, 0x4D : ext = "tiff"
      
    default: ext = "jpg" //unknown
    }
    
    return ext
  }

  /*----------------------------*/
  let destination : (NSURL, NSHTTPURLResponse) -> (NSURL) = {
    (temporaryURL, response) in
    
    if let directoryURL : NSURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]  {
      var localImageURL = directoryURL.URLByAppendingPathComponent("\("myPatch").\(response.suggestedFilename!)")
      return localImageURL
    }
    
    return temporaryURL
  }
  
  func baseDownload(progressDownloading : RestDownloadProgress, completion: RestAPICompletion) {
    Alamofire.Manager.sharedInstance.download(.GET, "http://www.planwallpaper.com/static/images/city-under-construction-1080p-full-hd-wallpaper.jpg"/*self.baseUrl*/, parameters: self.parameters, encoding: .JSON, headers: self.headers, destination: destination)
      .progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
        dispatch_async(dispatch_get_main_queue()) {
          //print("Total bytes read on main queue: \(totalBytesRead)")
          progressDownloading(bytesRead: bytesRead, totalBytesRead: totalBytesRead, totalBytesExpectedToRead: totalBytesExpectedToRead)
        }
      }
      .response { _, _, _, error in
        if let error = error {
          print("Failed with error: \(error)")
        } else {
          print("Downloaded file successfully")
        }
    }
  }
  
  class func downloadImage(url: String, completion: (String)->()) {
    let encodeURL = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
    NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: encodeURL!)!, completionHandler: { (data, response, error) in
      if data != nil {
        
        guard let downloadedImage = UIImage(data: data!) else {
          return
        }
        if let imageName = Utils.saveImageToDocument(downloadedImage) as String? {
          completion(imageName)
        }
      }
    }).resume()
  }
  
  class func downloadImageDocumentFile(url: String, completion: (String?) -> ()) {
    let encodeURL = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
    NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: encodeURL!)!, completionHandler: { (data, response, error) in
      
      if data != nil {
        
        guard let downloadedImage = UIImage(data: data!) else {
          return
        }
        if let imageName = Utils.saveImageToDocument(downloadedImage) as String? {
          completion(imageName)
        }
      }
      else {
        completion(nil)
      }
    }).resume()
  }
}

