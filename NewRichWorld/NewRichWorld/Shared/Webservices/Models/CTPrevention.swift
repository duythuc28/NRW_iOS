//
//  CTPrevention.swift
//  Chantier
//
//  Created by Mobile03 on 8/30/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class CTPrevention: Mappable {
  dynamic var remoteId = 0
  dynamic var name = ""
  dynamic var surname = ""
  dynamic var birthdate = NSDate()
  dynamic var function = ""
  dynamic var photo = ""
  dynamic var email = ""
  dynamic var telephone = ""
  
  convenience required init?(_ map: Map) {
    self.init()
  }
  
   func mapping(map: Map) {

    
    self.remoteId     <- map["id"]
    self.name         <- map["name"]
    self.surname      <- map["surname"]
    self.birthdate    <- (map["birthdate"], DateTransform())
    self.function     <- map["function"]
    self.photo        <- map["photo"]
    self.email        <- map["email"]
    self.telephone    <- map["telephone"]
  }
}
