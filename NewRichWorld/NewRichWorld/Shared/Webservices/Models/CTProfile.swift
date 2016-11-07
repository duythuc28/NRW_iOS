//
//  CTProfile.swift
//  Chantier
//
//  Created by iOS Dev on 8/15/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class CTProfile: RESTResponse {
  dynamic var id = 0
  dynamic var firstName = ""
  dynamic var lastName = ""
  dynamic var birthday = NSDate()
  dynamic var function = ""
  dynamic var service = ""
  dynamic var chargePrevention = ""
  dynamic var email = ""
  dynamic var address = ""
  dynamic var complementAddress = ""
  dynamic var codePostal = ""
  dynamic var city = ""
  dynamic var country = ""
  dynamic var phone = ""
  dynamic var phoneCustom = ""
  dynamic var emergencyContact = ""
  dynamic var emergencyPhone = ""
  dynamic var picture = ""
  dynamic var localPicture = ""
  dynamic var sms = ""
  dynamic var welcomeDay = NSDate()
  dynamic var welcomeComment = ""
  dynamic var modifiedDate = NSDate.init(timeIntervalSince1970: 0)
  dynamic var agency = ""
  dynamic var user: CTUser?
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  convenience required init?(_ map: Map) {
    self.init()
  }
  
  override func mapping(map: Map) {
    super.mapping(map)
    
    self.id                   <- map["id"]
    self.firstName            <- map["name"]
    self.lastName             <- map["surname"]
    self.birthday             <- (map["birthday"], DateTransform())
    self.function             <- map["function"]
    self.service              <- map["service"]
    self.chargePrevention     <- map["chargePrevention"]
    self.email                <- map["email"]
    self.address              <- map["address"]
    self.complementAddress    <- map["complementAddress"]
    self.codePostal           <- map["codePostal"]
    self.city                 <- map["city"]
    self.country              <- map["country"]
    self.phone                <- map["phone"]
    self.phoneCustom          <- map["phoneCustom"]
    self.emergencyContact     <- map["emergencyContact"]
    self.emergencyPhone       <- map["emergencyPhone"]
    self.picture              <- map["photo"]
    self.sms                  <- map["sms"]
    self.welcomeDay           <- (map["welcomeDay"], DateTransform())
    self.welcomeComment       <- map["welcomeComment"]
    self.modifiedDate         <- (map["modified_date"], DateTransform())
    self.agency               <- map["agency"]
  }
}
