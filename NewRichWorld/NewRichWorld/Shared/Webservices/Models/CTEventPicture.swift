//
//  CTEventPicture.swift
//  Chantier
//
//  Created by iOS Dev on 8/18/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class CTEventPicture: RESTResponse {
  dynamic var id = 0
  dynamic var picture = ""
  dynamic var localPicture = ""
  dynamic var event: CTEvent?
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  convenience required init?(_ map: Map) {
    self.init()
  }
  
  override func mapping(map: Map) {
    super.mapping(map)
    self.picture              <- map["picture"]
  }
}

