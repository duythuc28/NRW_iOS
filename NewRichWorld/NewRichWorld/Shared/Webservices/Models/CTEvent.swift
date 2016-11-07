//
//  CTEvent.swift
//  Chantier
//
//  Created by iOS Dev on 8/15/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class CTEvent: RESTResponse {
  dynamic var id = 0
  dynamic var remoteId = 0
  dynamic var title = ""
  dynamic var comment = ""
  dynamic var date = NSDate()
  var picture = []
  dynamic var modifiedDate = NSDate.init(timeIntervalSince1970: 0)
  dynamic var type: CTEventType?
  dynamic var site: CTSite?
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  convenience required init?(_ map: Map) {
    self.init()
  }
  
  
  override func mapping(map: Map) {
    super.mapping(map)
    
    self.remoteId             <- map["id"]
    self.title                <- (map["title"], StringFalseTransform())
    self.comment              <- (map["comment"], StringFalseTransform())
    self.date                 <- (map["date"], DateTransform())
    self.type                 <- (map["type"], EventTypeTransform())
//    self.picture              <- (map["pictures"], CTArrayTransform<CTEventPicture>())
    self.picture              <- map["pictures"]
    self.modifiedDate             <- (map["modified_date"], DateTransform())
  }
  
  override class func ignoredProperties() -> [String] {
    return ["picture"]
  }
}

class EventTypeTransform: TransformType {
  typealias Object = CTEventType
  typealias JSON = Int
  
  init() {
  }
  
  func transformFromJSON(value: AnyObject?) -> CTEventType? {
    if let typeID = value as? Int {
      if let eventType = CTEventTypeLoader.sharedInstance.query("remoteId = \(typeID)").first as? CTEventType {
        return eventType
      }
    }
    return nil
  }
  
  func transformToJSON(value: CTEventType?) -> Int? {
    if let eventType = value {
      return eventType.remoteId
    }
    return nil
  }
}

