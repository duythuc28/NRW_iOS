//
//  CTTally.swift
//  Chantier
//
//  Created by iOS Dev on 8/15/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class CTTally: RESTResponse {
  dynamic var id = 0
  dynamic var remoteId = 0
  dynamic var date = NSDate()
  dynamic var dayWork = 0.0
  dynamic var nightWork = 0.0
  dynamic var badWeatherWork = 0.0
  dynamic var timeWithoutWork = 0.0
  dynamic var comment = ""
  dynamic var user: CTUser?
  dynamic var site: CTSite?
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  convenience required init?(_ map: Map) {
    self.init()
  }
  
  override func mapping(map: Map) {
    super.mapping(map)
    
    self.date                   <- (map["date"], DateTransform())
    self.dayWork                <- map["day_hours"]
    self.nightWork              <- map["night_hours"]
    self.badWeatherWork         <- map["badweather_hours"]
    self.timeWithoutWork        <- map["withoutwork"]
    self.comment                <- map["comment"]
    self.user                   <- (map["collaboratorid"], CTUserTransform())
  }
}

class CTUserTransform: TransformType {
  typealias Object = CTUser
  typealias JSON = Int
  
  init() {}
  
  func transformFromJSON(value: AnyObject?) -> CTUser? {
    // TODO
    if let localId = value as? Int {
      return CTUserLoader.sharedInstance.query("id = \(localId)").first as? CTUser
    }
    return nil
  }
  
  func transformToJSON(value: CTUser?) -> Int? {
    return value?.remoteID
  }
}