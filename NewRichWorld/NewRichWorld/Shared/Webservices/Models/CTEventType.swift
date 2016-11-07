//
//  CTEventType.swift
//  Chantier
//
//  Created by iOS Dev on 8/15/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class CTEventType: RESTResponse {
  dynamic var id = 0
  dynamic var remoteId = 0
  dynamic var title = ""
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  convenience required init?(_ map: Map) {
    self.init()
  }
  
  override func mapping(map: Map) {
    super.mapping(map)
    
    self.remoteId             <- map["id"]
    self.title                <- map["title"]
  }
}
