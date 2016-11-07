//
//  CTNotification.swift
//  Chantier
//
//  Created by iOS Dev on 8/15/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class CTNotification: RESTResponse {
  dynamic var id = 0
  dynamic var remoteId = 0
  dynamic var organization_RemoteId = 0
  dynamic var notificationDesctiption = ""
  dynamic var active = false
  dynamic var created = NSDate()
  dynamic var modified = NSDate()
  dynamic var organisation: CTOrganisation?
  var user: CTUser?
  override static func primaryKey() -> String? {
    return "id"
  }
  
  convenience required init?(_ map: Map) {
    self.init()
  }
  
  override func mapping(map: Map) {
    super.mapping(map)
    
    self.remoteId                 <- map["id"]
    self.organization_RemoteId          <- map["organization_id"]
    self.notificationDesctiption  <- (map["text"], StringFalseTransform())
    self.active                   <- map["active"]
    self.created                  <- (map["created"], DateTransform())
    self.modified                 <- (map["modified"], DateTransform())
  }
}
