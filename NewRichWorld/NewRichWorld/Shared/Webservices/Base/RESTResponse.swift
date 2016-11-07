
import UIKit
import ObjectMapper
import RealmSwift
import SwiftyJSON

class RESTResponse: Object, Mappable {
  
  //error status
  dynamic var statusCode = 0
  
  //error message
  dynamic var message = ""
  
  convenience required init?(_ map: Map) {
    self.init()
  }
  
  func mapping(map: Map) {
    self.message      <- map["message"]
    
    if map.JSONDictionary["status"] != nil {
      self.statusCode <- map["status"]
    } else {
      self.statusCode <- map["code"]
    }
  }
  
  func toDictionary() -> [String : AnyObject] {
    return self.toJSON()
  }
  
}

class ListTransform<T:RealmSwift.Object where T:Mappable> : TransformType {
  
  typealias Object = List<T>
  typealias JSON = Array<AnyObject>
  
  let mapper = Mapper<T>()
  
  func transformFromJSON(value: AnyObject?) -> List<T>? {
    let result = List<T>()
    if let tempArr = value as! Array<AnyObject>? {
      for entry in tempArr {
        let mapper = Mapper<T>()
        let model : T = mapper.map(entry)!
        result.append(model)
      }
    }
    
    return result
  }
  
  func transformToJSON(value: Object?) -> JSON? {
    var results = [AnyObject]()
    if let value = value {
      for obj in value {
        let json = mapper.toJSON(obj)
        results.append(json)
      }
    }
    
    return results
  }
  
}
