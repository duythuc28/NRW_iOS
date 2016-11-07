//
//  CTNews.swift
//  Chantier
//
//  Created by iOS Dev on 8/15/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class CTNews: RESTResponse {
  dynamic var id = 0
  dynamic var remoteId = 0
  dynamic var name = ""
  dynamic var intro = ""
  dynamic var body = ""
  dynamic var image = ""
  dynamic var localImage = ""
  dynamic var date = NSDate()
  dynamic var type = ""
  dynamic var organisation: CTOrganisation?
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  convenience required init?(_ map: Map) {
    self.init()
  }
  
  override func mapping(map: Map) {
    super.mapping(map)
    
    self.remoteId             <- map["id"]
    self.name                 <- (map["name"], StringFalseTransform())
    self.intro                <- (map["intro"], StringFalseTransform())
    self.body                 <- (map["body"], StringFalseTransform())
    self.image                <- (map["image"], StringFalseTransform())
    self.date                 <- (map["date"], DateTransform())
    self.type                 <- (map["type"], StringFalseTransform())
  }
}