//
//  CTSite.swift
//  Chantier
//
//  Created by iOS Dev on 8/15/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class CTSite: RESTResponse {
  dynamic var id = 0
  dynamic var remoteId = 0
  dynamic var name = ""
  dynamic var reference = ""
  dynamic var startDate = NSDate()
  dynamic var endDate = NSDate()
  dynamic var status = false
  dynamic var address1 = ""
  dynamic var address2 = ""
  dynamic var zipcode = ""
  dynamic var city = ""
  dynamic var country = ""
  dynamic var phone = ""
  dynamic var picture = ""
  dynamic var localPicture = ""
  dynamic var displacementZone = ""
  dynamic var emergencyPhone = ""
  dynamic var emergencyDescription = ""
  dynamic var modifiedDate = NSDate.init(timeIntervalSince1970: 0)
  dynamic var organisation: CTOrganisation?
  let owners = List<CTUser>()
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  convenience required init?(_ map: Map) {
    self.init()
  }
  
  override func mapping(map: Map) {
    super.mapping(map)
    
    self.remoteId            <- map["id"]
    self.name                <- (map["name"], StringFalseTransform())
    self.reference           <- (map["reference"], StringFalseTransform())
    self.startDate           <- (map["start_date"], DateTransform())
    self.endDate             <- (map["end_date"], DateTransform())
    self.status              <- map["status"]
    self.address1            <- (map["adresse1"], StringFalseTransform())
    self.address2            <- (map["adresse2"], StringFalseTransform())
    self.zipcode             <- (map["zip_code"], StringFalseTransform())
    self.city                <- (map["city"], StringFalseTransform())
    self.country             <- (map["country"], StringFalseTransform())
    self.phone               <- (map["phone"], StringFalseTransform())
    self.picture             <- (map["picture"], StringFalseTransform())
    self.displacementZone    <- (map["zone_deplacement"], StringFalseTransform())
    self.emergencyPhone      <- (map["emergency_phone"], StringFalseTransform())
    self.emergencyDescription <- (map["emergency_description"], StringFalseTransform())
    self.modifiedDate        <- (map["modified_date"], DateTransform())
  }
}