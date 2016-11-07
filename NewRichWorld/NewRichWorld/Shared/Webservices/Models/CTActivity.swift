//
//  CTActivity.swift
//  Chantier
//
//  Created by iOS Dev on 8/15/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class CTActivity: RESTResponse {
  dynamic var id = 0
  dynamic var remoteId = 0
  dynamic var activityDescription = ""
  dynamic var time = NSDate()
  dynamic var author = ""
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
    self.activityDescription  <- (map["description"], StringFalseTransform())
    self.time                 <- (map["time"], DateTransform())
    self.author               <- (map["author"], StringFalseTransform())
  }
}