
import UIKit
import ObjectMapper

class DLLoginParams: RESTParam {
  
  dynamic var email = ""
  dynamic var password = ""
  dynamic var fbId = ""
  dynamic var fbToken = ""
  dynamic var deviceToken = ""
  dynamic var deviceType = ""
  
  convenience init(email: String, password: String, fbId: String, fbToken: String, deviceToken: String, deviceType: String) {
    self.init()
    
    self.email = email
    self.password = password
    self.fbId = fbId
    self.fbToken = fbToken
    self.deviceToken = deviceToken
    self.deviceType = deviceType
  }
  
  override func mapping(map: Map) {
    self.email        <- map["email"]
    self.password     <- map["password"]
    self.fbId         <- map["fb_id"]
    self.fbToken      <- map["fb_token"]
    self.deviceToken  <- map["device_token"]
    self.deviceType   <- map["device_type"]
  }
  
}

class DLGetListParcelParams: RESTParam {
  
  dynamic var radius: Float = 0.0
  dynamic var latitude = ""
  dynamic var longitude = ""
  dynamic var limit = 20
  dynamic var offset  = 0
  
  convenience init(radius: Float, latitude: String, longitude: String) {
    self.init()
    
    self.radius = radius
    self.latitude = latitude
    self.longitude = longitude
    self.limit = 20
    self.offset = 0
  }
  
  override func mapping(map: Map) {
    self.radius       <- map["radius"]
    self.latitude     <- map["latitude"]
    self.longitude    <- map["longitude"]
    self.limit        <- map["limit"]
    self.offset       <- map["offset"]
  }
  
}

class DLListParcelOffersParams: RESTParam {
  
  dynamic var offset = 0
  dynamic var limit = 20
  
  convenience init(offset: Int, limit: Int) {
    self.init()

    self.offset = offset
    self.limit = limit
  }
  
  override func mapping(map: Map) {
    self.offset                 <- map["ofset"]
    self.limit                  <- map["limit"]
  }
  
}

//create Offer
class DLCreateOfferParams: RESTParam {
  
  dynamic var parcelID = ""
  dynamic var descriptionOffer = "description"
  dynamic var pickupTime = "pickup_time"
  dynamic var bidPrice = 0.0
  
  convenience init(parcelID: String, descriptionOffer: String, pickupTime: String, bidPrice: Double) {
    self.init()
    
    self.parcelID = parcelID
    self.descriptionOffer = descriptionOffer
    self.pickupTime = pickupTime
    self.bidPrice = bidPrice
  }
  
  override func mapping(map: Map) {
    self.parcelID           <- map["parcel_id"]
    self.descriptionOffer   <- map["description"]
    self.pickupTime         <- map ["pickup_time"]
    self.bidPrice           <- map ["bid_price"]
  }

}

//update profile user
class DLUpdateProfileParams: RESTParam {
  dynamic var firstName   = ""
  dynamic var lastName    = ""
  dynamic var address     = ""
  dynamic var phone       = ""
  dynamic var postalCode  = ""
  dynamic var country     = ""
  dynamic var userAvatar: UIImage?
  
  convenience init(firstName: String, lastName: String, address: String, phone: String, postalCode: String, country: String) {
    self.init()
    
    self.firstName  = firstName
    self.lastName   = lastName
    self.address    = address
    self.phone      = phone
    self.postalCode = postalCode
    self.country    = country
  }
  
  override func mapping(map: Map) {
    self.firstName     <- map["first_name"]
    self.lastName      <- map["last_name"]
    self.address       <- map["address"]
    self.phone         <- map["phone"]
    self.postalCode    <- map["postal_code"]
    self.country       <- map["country"]
    self.userAvatar    <- map["avatar"]
  }
  
  override func toDictionary() -> [String : AnyObject] {
    var dict = self.toJSON()
    if let avatar = userAvatar {
      dict["avatar"] = UIImageJPEGRepresentation(avatar, 0.7)!
    }
    return dict
  }
}

// Rating
class DLRatingParameter: RESTParam {
  dynamic var senderID    = ""
  dynamic var pilotID     = ""
  dynamic var parcelID    = ""
  dynamic var rate        = 0
  dynamic var reviewType  = 0
  
  convenience init(senderID: String, pilotID: String, parcelID: String, rate: Int, reviewType: Int) {
    self.init()
    
    self.senderID = senderID
    self.pilotID = pilotID
    self.parcelID = parcelID
    self.rate = rate
    self.reviewType = reviewType
  }
}
