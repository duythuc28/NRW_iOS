

import Foundation
import SwiftyJSON

class RESTMultipart: NSObject {
  
  var name: String! = ""
  var contentType: String! = ""
  var data: NSData!
  
  init(name: String!, contentType: String!, data: NSData!) {
    self.name = name
    self.contentType = contentType
    self.data = data
  }
  
  func getHeader() -> [String: String] {
    return ["Content-Disposition" : "form-data; name=\(self.name)", "Content-Type" :  self.contentType]
  }
  
  class JSONPart: RESTMultipart {
    init(name: String!, jsonObject: NSObject) {
      let data: NSData! = NSKeyedArchiver.archivedDataWithRootObject(JSON.init(jsonObject).dictionaryObject!)
      
      super.init(name: name, contentType: "application/json; charset=UTF-8", data: data)
    }
  }
  
  class FilePart: RESTMultipart {
    
    var fileName: String!
    
    init(name: String!, fileName: String!, data: NSData!) {
      super.init(name: name, contentType: "application/octet-stream", data: data)
      self.fileName = fileName
    }
    
    override func getHeader() -> [String: String] {
      var header = super.getHeader()
      header["Content-Disposition"] = "form-data; name=\"\(self.name)\"; filename=\"\(self.fileName)\""
      return header
    }
  }
  
}
