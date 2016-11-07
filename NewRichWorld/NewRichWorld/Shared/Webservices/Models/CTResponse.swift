//
//  CTResponse.swift
//  Chantier
//
//  Created by iOS Dev on 8/31/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class CTPreventionContentsLast: Mappable {
  var id = 0
  var themeId = 0
  var themeName = ""
  var themeDescription = ""
  var themeImage = ""
  var name = ""
  var image = ""
  var lastDate = NSDate()
  var fileContent = ""
  
  required init?(_ map: Map) {
    
  }
  
  func mapping(map: Map) {
    self.id                   <- map["id"]
    self.themeId              <- map["theme_id"]
    self.themeName            <- (map["theme_name"], StringFalseTransform())
    self.themeDescription     <- (map["theme_description"], StringFalseTransform())
    self.themeImage           <- (map["theme_image"], StringFalseTransform())
    self.name                 <- (map["name"], StringFalseTransform())
    self.image                <- (map["image"], StringFalseTransform())
    self.lastDate             <- (map["last_modification_date"], DateTransform())
    self.fileContent          <- (map["filecontent"], StringFalseTransform())
  }
}

class CTUserLogin: Mappable {
  var firstName = ""
  var lastName = ""
  var function = ""
  var accessToken = ""
  var tokenType = ""
  var refreshToken = ""
  var expires =  NSDate()
  
  required init?(_ map: Map) {
    
  }
  
  func mapping(map: Map) {
    self.firstName              <- (map["first_name"], StringFalseTransform())
    self.lastName               <- (map["last_name"], StringFalseTransform())
    self.function               <- (map["function"], StringFalseTransform())
    self.accessToken            <- (map["access_token"], StringFalseTransform())
    self.tokenType              <- (map["token_type"], StringFalseTransform())
    self.refreshToken           <- (map["refresh_token"], StringFalseTransform())
    self.expires                <- (map["expires"], DateTransform())
  }
}

class CTSiteCollaborator: Mappable {
  var id = 0

  required init?(_ map: Map) {
    
  }
  
  func mapping(map: Map) {
    self.id            <- map["id"]
  }
}

class CTPrevention: Mappable {
  dynamic var remoteId = 0
  dynamic var name = ""
  dynamic var surname = ""
  dynamic var birthdate = NSDate()
  dynamic var function = ""
  dynamic var photo = ""
  dynamic var email = ""
  dynamic var telephone = ""
  dynamic var modifiedDate = NSDate.init(timeIntervalSince1970: 0)
  
  required init?(_ map: Map) {
    
  }
  
  func mapping(map: Map) {
    self.remoteId     <- map["id"]
    self.name         <- (map["name"], StringFalseTransform())
    self.surname      <- (map["surname"], StringFalseTransform())
    self.birthdate    <- (map["birthdate"], DateTransform())
    self.function     <- (map["function"], StringFalseTransform())
    self.photo        <- (map["photo"], StringFalseTransform())
    self.email        <- (map["email"], StringFalseTransform())
    self.telephone    <- (map["phone"], StringFalseTransform())
    self.modifiedDate <- (map["modified_date"], DateTransform())
  }
}

class CTCollborator: Mappable {
  dynamic var remoteId = 0
  dynamic var name = ""
  dynamic var surname = ""
  dynamic var birthdate = NSDate()
  dynamic var function = ""
  dynamic var preventer = ""
  dynamic var photo = ""
  dynamic var email = ""
  dynamic var phone = ""
  dynamic var modifiedDate = NSDate.init(timeIntervalSince1970: 0)
  
  required init?(_ map: Map) {
    
  }
  
  func mapping(map: Map) {
    self.remoteId     <- map["id"]
    self.name         <- (map["name"], StringFalseTransform())
    self.surname      <- (map["surname"], StringFalseTransform())
    self.birthdate    <- (map["birthdate"], StringDateTransform())
    self.function     <- (map["function"], StringFalseTransform())
    self.preventer    <- (map["preventer"], StringFalseTransform())
    self.photo        <- (map["photo"], StringFalseTransform())
    self.email        <- (map["email"], StringFalseTransform())
    self.phone        <- (map["phone"], StringFalseTransform())
    self.modifiedDate <- (map["modified_date"], DateTransform())
  }
}

class StringDateTransform: TransformType {
  typealias Object = NSDate
  typealias JSON = String
  
  var dateFormater = NSDateFormatter()
  
  init() {
    dateFormater.dateFormat = "yyyy-MM-dd"
    dateFormater.locale = NSLocale.currentLocale()
  }
  
  func transformFromJSON(value: AnyObject?) -> NSDate? {
    if let timeStr = value as? String {
      return dateFormater.dateFromString(timeStr)
    }
    return nil
  }
  
  func transformToJSON(value: NSDate?) -> String? {
    if let date = value {
      return dateFormater.stringFromDate(date)
    }
    return nil
  }
}

class CTCollaboratorAdd: Mappable {
  var collaborators: [Int] = []
  
  required init?(_ map: Map) {
  }
  
  func mapping(map: Map) {
    self.collaborators     <- map["collaborators"]
  }
}


class CTCollaboratorCreateAndAdd: Mappable {
  var collaboratorId = 0
  
  required init?(_ map: Map) {
  }
  
  func mapping(map: Map) {
    self.collaboratorId     <- map["collaborator_id"]
  }
}

class CTAdviser: Mappable {
  dynamic var name = ""
  dynamic var surname = ""
  dynamic var photo = ""
  dynamic var phone = ""
  dynamic var email = ""
  dynamic var agency = ""
  
  required init?(_ map: Map) {
    
  }
  
  func mapping(map: Map) {
    self.name         <- (map["name"], StringFalseTransform())
    self.surname      <- (map["surname"], StringFalseTransform())
    self.photo        <- (map["photo"], StringFalseTransform())
    self.email        <- (map["email"], StringFalseTransform())
    self.phone        <- (map["phone"], StringFalseTransform())
    self.agency       <- (map["agency"], StringFalseTransform())
  }
}

class CTOrganisationCategoryDocument: Mappable {
  dynamic var id = 0
  dynamic var remoteId = 0
  dynamic var name = ""
  dynamic var organisation: CTOrganisation?
  dynamic var documents: [CTDocument] = [CTDocument]()
  
  static func primaryKey() -> String? {
    return "id"
  }
  
  convenience required init?(_ map: Map) {
    self.init()
  }
  
  func mapping(map: Map) {
    
    self.remoteId             <- map["id"]
    self.name                 <- (map["name"], StringFalseTransform())
    self.documents            <- map["documents"]
  }
}

class StringFalseTransform: TransformType {
  typealias Object = String
  typealias JSON = String
  
  init() {}
  
  func transformFromJSON(value: AnyObject?) -> String? {
    if let string = value as? String where string.rangeOfString("false") != nil {
      return ""
    }
    
    if let _ = value as? Bool{
      return ""
    }
    
    return value as? String
  }
  
  func transformToJSON(value: String?) -> String? {
    return value
  }
}