//
//  CTUser.swift
//  Chantier
//
//  Created by iOS Dev on 8/15/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class CTUser: RESTResponse {
  dynamic var id = 0
  dynamic var remoteID = 0
  dynamic var password = ""
  dynamic var saltHash = ""
  dynamic var username = ""
  dynamic var token = ""
  dynamic var refreshToken = ""
  dynamic var expires = NSDate()
  dynamic var role: CTRole?
  dynamic var userType: CTUserType?
  let sites = List<CTSite>()
  let organisations = List<CTOrganisation>()
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  convenience required init?(_ map: Map) {
    self.init()
  }
  
  override func mapping(map: Map) {
    super.mapping(map)
    
    self.id                   <- map["id"]
    self.remoteID             <- map["remote_id"]
    self.password             <- map["password"]
    self.saltHash             <- map["saltHash"]
    self.username             <- map["username"]
    self.refreshToken         <- map["refresh_token"]
    self.expires              <- (map["expires"], DateTransform())
  }
}