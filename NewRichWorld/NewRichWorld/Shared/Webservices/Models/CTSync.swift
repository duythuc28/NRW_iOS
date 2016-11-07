//
//  CTSync.swift
//  Chantier
//
//  Created by iOS Dev on 8/17/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class CTSync: Object, Mappable {
  dynamic var functionName = ""
  dynamic var param = ""
  dynamic var created = NSDate()
  dynamic var isSend = false
  dynamic var owner: CTUser?
  
  convenience required init?(_ map: Map) {
    self.init()
  }
  
  func mapping(map: Map) {
    self.functionName   <- map["functionName"]
    self.param          <- map["param"]
    self.created        <- map["created"]
    self.isSend         <- map["isSend"]
    self.owner          <- map["owner"]
  }
}