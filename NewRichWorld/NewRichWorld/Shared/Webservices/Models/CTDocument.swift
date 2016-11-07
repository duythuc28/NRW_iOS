//
//  CTDocument.swift
//  Chantier
//
//  Created by iOS_Dev on 8/15/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class CTDocument: RESTResponse {
  dynamic var id = 0
  dynamic var remoteId = 0
  dynamic var name = ""
  dynamic var file = ""
  dynamic var localFile = ""
  dynamic var previewImage = "" // Only for preventioncontentslast
  dynamic var localPreviewImage = "" // Only for preventioncontentslast
  dynamic var type = "" // preventioncontentslast, normal, sitedocument, themedocument
  dynamic var date = NSDate()
  dynamic var category: CTCategory?
  
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
    self.file                 <- (map["file"], StringFalseTransform())
    self.date                 <- (map["created"], DateTransform())
  }
}

let transformStringToInt = TransformOf<Int, String>(fromJSON: { (value: String?) -> Int? in
  // transform value from String? to Int?
  return Int(value!)
  }, toJSON: { (value: Int?) -> String? in
    // transform value from Int? to String?
    if let value = value {
      return String(value)
    }
    return nil
})