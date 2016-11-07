//
//  CTParameters.swift
//  Chantier
//
//  Created by iOS Dev on 8/18/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

/*------------------------------------------------*/
class CTSiteAddParams: RESTParam {
  
  dynamic var organizationID = 0
  dynamic var siteID = 0
  dynamic var name = ""
  dynamic var reference = ""
  dynamic var dateStart = NSDate()
  dynamic var city = ""
  dynamic var zipcode = ""
  
  convenience init(organizationID: Int, siteID: Int, name: String, reference: String, dateStart: NSDate, city: String, zipcode: String) {
    self.init()
    
    self.organizationID = organizationID
    self.siteID = siteID
    self.name = name
    self.reference = reference
    self.dateStart = dateStart
    self.city = city
    self.zipcode = zipcode
  }
  
  override func mapping(map: Map) {
    self.organizationID       <- map["organizationid"]
    self.siteID               <- map["site_id"]
    self.name                 <- map["name"]
    self.reference            <- map["reference"]
    self.dateStart            <- (map["date_start"], DateTransform())
    self.city                 <- map["city"]
    self.zipcode              <- map["zipcode"]
  }
  
  override func toDictionary() -> [String : AnyObject] {
    var dict = self.toJSON()
    dict.removeValueForKey("site_id")
    return dict
  }
}
/*------------------------------------------------*/
class CTSiteUpdateParams: RESTParam {
  
  dynamic var organizationID = 0
  dynamic var siteID = 0
  dynamic var name = ""
  dynamic var reference = ""
  dynamic var dateStart = NSDate()
  dynamic var city = ""
  dynamic var zipcode = ""
  dynamic var picture = ""
  
  convenience init(organizationID: Int, siteID: Int, name: String, reference: String, dateStart: NSDate, city: String, zipcode: String, picture: String) {
    self.init()
    
    self.organizationID = organizationID
    self.siteID = siteID
    self.name = name
    self.reference = reference
    self.dateStart = dateStart
    self.city = city
    self.zipcode = zipcode
    self.picture = picture
  }
  
  override func mapping(map: Map) {
    self.organizationID       <- map["organizationid"]
    self.siteID               <- map["site_id"]
    self.name                 <- map["name"]
    self.reference            <- map["reference"]
    self.dateStart            <- (map["date_start"], DateTransform())
    self.city                 <- map["city"]
    self.zipcode              <- map["zipcode"]
    self.picture              <- map["picture"]
  }
  
  override func toDictionary() -> [String : AnyObject] {
    var dict = self.toJSON()
    dict.removeValueForKey("site_id")
    
    // Get site picture for filename
    if let image = Utils.loadImageFromDocument(dict["picture"] as? String ?? "") {
      dict["picture"] =  UIImageJPEGRepresentation(image, 0.7)
    }
    
    return dict
  }
}
/*------------------------------------------------*/

/*------------------------------------------------*/
class CTCollaboratorAddParams: RESTParam {
  
  dynamic var siteID = 0
  dynamic var collaborators: [Int] = []
  
  convenience init(siteID: Int, collaborators: [Int]) {
    self.init()
    self.siteID = siteID
    self.collaborators = collaborators
  }
  
  override func mapping(map: Map) {
    self.siteID               <- map["siteid"]
    self.collaborators        <- map["collaborators"]
  }
  
  override func toDictionary() -> [String : AnyObject] {
    var dict = self.toJSON()
    var collaboratorsJSON: [AnyObject] = []
    for id in collaborators {
      if let collaborator = CTUserLoader.sharedInstance.query("id = \(id)").first as? CTUser {
        collaboratorsJSON.append(Int(collaborator.remoteID))
      }
    }
    dict["collaborators"] = collaboratorsJSON
    return dict
  }
}
/*------------------------------------------------*/
class CTCollaboratorCreateAndAddParams: RESTParam {
  
  dynamic var organizationID = 0
  dynamic var siteID = 0
  dynamic var collaboratorId = 0 // Collaborator ID -> 0: Don't exist, !0: Exist with id
  dynamic var lastname = ""
  dynamic var firstname = ""
  dynamic var birthdate = NSDate()
  dynamic var photo = ""
  
  convenience init(organizationID: Int, siteID: Int, lastname: String, firstname: String, birthdate: NSDate, photo: String) {
    self.init()
    
    self.organizationID = organizationID
    self.siteID = siteID
    self.lastname = lastname
    self.firstname = firstname
    self.birthdate = birthdate
    self.photo = photo
  }
  
  override func mapping(map: Map) {
    self.organizationID       <- map["organizationid"]
    self.siteID               <- map["siteid"]
    self.collaboratorId       <- map["collaboratorid"]
    self.lastname             <- map["lastname"]
    self.firstname            <- map["firstname"]
    self.birthdate            <- (map["birthdate"], DateTransform())
    self.photo                <- map["photo"]
  }
  
  override func toDictionary() -> [String : AnyObject] {
    var dict = super.toDictionary()
    dict.removeValueForKey("collaboratorid")
    
    // Get collaborator picture from filename
    if let image = Utils.loadImageFromDocument(dict["photo"] as? String ?? "") {
      dict["photo"] =  UIImageJPEGRepresentation(image, 0.7)
    }
    return dict
  }
}
/*------------------------------------------------*/
class CTEventAddParams: RESTParam {
  
  dynamic var eventID = 0
  dynamic var siteID = 0
  dynamic var title = ""
  dynamic var date = NSDate()
  dynamic var comment = ""
  dynamic var eventType = 0
  dynamic var eventTypeLabel = ""
  dynamic var pictures: [String] = []
  
  convenience init(siteID: Int, title: String, date: NSDate, comment: String, eventType: Int, pictures: [String]) {
    self.init()
    
    self.siteID = siteID
    self.title = title
    self.date = date
    self.comment = comment
    self.eventType = eventType
    self.pictures = pictures
  }
  
  override func mapping(map: Map) {
    self.eventID              <- map["eventid"]
    self.siteID               <- map["siteid"]
    self.title                <- map["title"]
    self.date                 <- (map["date"], DateTransform())
    self.comment              <- map["comment"]
    self.eventType            <- map["type"]
    self.eventTypeLabel       <- map["eventtype_label"]
    self.pictures             <- map["pictures[]"]
  }
  
  // Convert image filename to base64 image data
  override func toDictionary() -> [String : AnyObject] {
    var dict = super.toDictionary()
    
    // TODO: Get collaborator picture for filename
    var listPicture: [NSData] = []
    if let pictures = dict["pictures[]"] as? [String] {
      for picture in pictures {
        if let image = Utils.loadImageFromDocument(picture), let imageData = UIImageJPEGRepresentation(image, 0.7) {
          listPicture.append(imageData)
        }
      }
    }
    
    dict["pictures[]"] = listPicture
    
    return dict
  }
}
/*------------------------------------------------*/
class CTWelcomeAddParams: RESTParam {
  
  dynamic var siteID = 0
  dynamic var collaborators: [Int] = [] // Array local id
  dynamic var dateWelcome = NSDate()
  dynamic var pictures = []
  dynamic var comment = ""
  
  convenience init(siteID: Int, collaborators: [Int], dateWelcome: NSDate, pictures: [String], comment: String) {
    self.init()
    
    self.siteID = siteID
    self.collaborators = collaborators
    self.dateWelcome = dateWelcome
    self.pictures = pictures
    self.comment = comment
  }
  
  override func mapping(map: Map) {
    self.siteID               <- map["siteid"]
    self.collaborators        <- map["collaborators[]"]
    self.dateWelcome          <- (map["date_welcome"], DateTransform())
    self.pictures             <- map["pictures[]"]
    self.comment              <- map["comment"]
  }
  
  // Convert image filename to base64 image data
  override func toDictionary() -> [String : AnyObject] {
    var dict = super.toDictionary()
    
    // TODO: Get collaborator picture for filename
    var listPicture: [NSData] = []
    if let pictures = dict["pictures[]"] as? [String] {
      for picture in pictures {
        if let image = Utils.loadImageFromDocument(picture), let imageData = UIImageJPEGRepresentation(image, 0.7) {
          listPicture.append(imageData)
        }
      }
    }
    
    dict["pictures[]"] = listPicture
    
    // Get collaborator remote id for local id
    var collaboratorsJSON: [Int] = []
    for item in collaborators {
      if let collaborator = CTUserLoader.sharedInstance.query("id = \(item)").first as? CTUser {
        collaboratorsJSON.append(collaborator.remoteID)
      }
    }
    dict["collaborators[]"] = collaboratorsJSON
    
    return dict
  }
}
/*------------------------------------------------*/
class CTTallyAddParams: RESTParam {
  
  dynamic var siteID = 0
  dynamic var collaborators: [CTTally] = []
  dynamic var tallies: [Int] = []
  
  convenience init(siteID: Int, collaborators: [CTTally]) {
    self.init()
    
    self.siteID = siteID
    self.collaborators = collaborators
  }
  
  override func toDictionary() -> [String : AnyObject] {
    var dict = self.toJSON()
    if tallies.count == 0 {
      dict["collaborators"] = collaborators.toJSON()
    } else {
      var talliesJSON: [AnyObject] = []
      for item in tallies {
        if let tally = CTTallyLoader.sharedInstance.query("id = \(item)").first as? CTTally {
          talliesJSON.append(CTTally(value: tally).toJSON())
        }
      }
      dict["collaborators"] = talliesJSON
    }
    return dict
  }
  
  override func mapping(map: Map) {
    self.siteID               <- map["siteid"]
    self.tallies              <- map["collaborators"]
  }
}
