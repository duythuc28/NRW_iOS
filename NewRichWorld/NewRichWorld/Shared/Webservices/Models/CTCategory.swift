//
//  CTCategory.swift
//  Chantier
//
//  Created by iOS_Devs on 8/15/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class CTCategory: RESTResponse {
  dynamic var id = 0
  dynamic var remoteId = 0
  dynamic var name = ""
  dynamic var categoryDescription = ""
  dynamic var organisation: CTOrganisation?
  dynamic var site: CTSite?
  dynamic var theme: CTTheme?
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  convenience required init?(_ map: Map) {
    self.init()
  }
  
  override func mapping(map: Map) {
    super.mapping(map)
    
    self.id                   <- map["id"]
    self.name                 <- map["name"]
    self.categoryDescription  <- map["description"]
  }
}