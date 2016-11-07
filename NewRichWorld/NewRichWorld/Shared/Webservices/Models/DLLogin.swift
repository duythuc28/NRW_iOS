//
//  DLLogin.swift
//  Dliver
//
//  Created by iOS_Dev on 7/11/16.
//  Copyright © 2016 SutrixSolutions. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
import SwiftyJSON

class DLUserInfo: RESTResponse {
  
  dynamic var accountId = ""
  dynamic var email = ""
  dynamic var firstName = ""
  dynamic var lastName = ""
  dynamic var address = ""
  dynamic var phone = ""
  dynamic var postalCode = ""
  dynamic var country = ""
  dynamic var ratingSum = 0
  dynamic var ratingCount = 0
  dynamic var accountToken = ""
  dynamic var avatarURL = ""
  dynamic var city = ""
  dynamic var isPinned = false
  
  convenience required init?(_ map: Map) {
    self.init()
  }
  
  override func mapping(map: Map) {
    super.mapping(map)
    
    self.accountId         <- map["data.account_id"]
    self.email             <- map["data.email"]
    self.firstName         <- map["data.first_name"]
    self.lastName          <- map["data.last_name"]
    self.address           <- map["data.address"]
    self.phone             <- map["data.phone"]
    self.postalCode        <- map["data.postal_code"]
    self.country           <- map["data.country"]
    self.ratingSum         <- map["data.rating_sum"]
    self.ratingCount       <- map["data.rating_count"]
    self.accountToken      <- map["data.account_token"]
    self.avatarURL         <- map["data.avatar"]
    self.city              <- map["data.city"]
    self.isPinned          <- map["data.is_pin"]
  }
  
}
