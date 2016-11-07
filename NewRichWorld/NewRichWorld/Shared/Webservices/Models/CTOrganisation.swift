//
//  CTOrganisation.swift
//  Chantier
//
//  Created by iOS Dev on 8/15/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class CTOrganisation: RESTResponse {
  dynamic var id = 0
  dynamic var remoteId = 0
  dynamic var name = ""
  dynamic var logo = ""
  dynamic var localLogo = ""
  dynamic var emergencyPhone = ""
  dynamic var emergencyAdvice = ""
  dynamic var modifiedDate = NSDate.init(timeIntervalSince1970: 0)
  let users = List<CTUser>()
  
  //local variable hold check status
  var isChecked = false
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  convenience required init?(_ map: Map) {
    self.init()
  }
  
  override func mapping(map: Map) {
    super.mapping(map)
    
    self.remoteId                 <- map["id"]
    self.name                     <- (map["name"], StringFalseTransform())
    self.logo                     <- (map["logo"], StringFalseTransform())
    self.emergencyPhone           <- (map["emergency_phone"], StringFalseTransform())
    self.emergencyAdvice          <- (map["emergency_advices"], StringFalseTransform())
    self.modifiedDate             <- (map["modified_date"], DateTransform())
  }
  
  func toJSON() -> [String : AnyObject] {
    let json = self.toJSON()
    let result = json["organizations"]!.toJSON()
    
    return result
  }
  
  override class func ignoredProperties() -> [String] {
    return ["isChecked"]
  }
}

