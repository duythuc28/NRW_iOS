
import UIKit
import ObjectMapper

class RESTParam: NSObject, Mappable {
  
  override init() {
    super.init()
  }
  
  convenience required init?(_ map: Map) {
    self.init()
  }
  
  func mapping(map: Map) {
    
  }
  
  func toDictionary() -> [String : AnyObject] {
    return self.toJSON()
  }
  
}
