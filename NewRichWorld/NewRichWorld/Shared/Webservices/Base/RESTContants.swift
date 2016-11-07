//
//  RESTContants.swift
//  9Gags
//
//  Created by iOs_Dev on 1/8/16.
//  Copyright © 2016 Duong Tran. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreLocation

class RESTContants: NSObject {
  
  //MARK: RESTRequest Header Keys
  static let RequestHeaderKey                   = "Header"
  static let RequestAuthorizationKey            = "Authorization"
  static let RequestContentTypeKey              = "Content-Type"
  static let RequestAcceptKey                   = "Accept"
  static let Headers                            = [:]//["Content-Type" : "application/json"]
  static let PrefixToken                        = "Bearer "
  
  //MARK: Keys for parser
  static let SuccessKeyFromResponseData         = "status"
  static let MessageKeyFromResponseData         = "error"
  static let DefaultMessageKeyFromResponseData  = "unknow_error"
  
  //MARK: Prepairing request
  static let RequestTimeOut                     = 90.0
  static let StatusCodeSuccess                  = 200
  static let StatusCodeAdded                    = 201
  static let StatusCodeLogin                    = 302
  static let Unathorizated                      = 401
  static let MethodNotAllowed                   = 405
  
  //MARK: Webservice url
  static let Hostname                           = "preprod.preventionbtp.fr"
  static let WebserviceUrl                      = "https://preprod.preventionbtp.fr/api/appchantier/v2/"
  static let WebserviceResourceUrl              = ""
  static let Login                              = "https://preprod.preventionbtp.fr/oauth-token/login"
  static let ForgotPassword                     = "https://preprod.preventionbtp.fr/oauth-token/forgotpassword"
  static let GetListCategories                  = "get-categories"
  static let GetListTransports                  = "get-transports"
  static let GetListParcel                      = "get-parcels"
  static let GetListOffer                       = "get-offers"
  static let GetParcelDetail                    = "parcel-detail"
  static let GetOfferDetail                     = "offer-detail"
  static let CreateParcel                       = "create-parcel"
  static let GetParcelOffers                    = "get-parcels-offers"
  static let GetUserProfile                     = "account-detail"
  static let AcceptedOffer                      = "accept-offer"
  static let CreateOffer                        = "create-offer"
  static let PilotChangeStatus                  = "change-offer-status"
  static let PilotCancelOffer                   = "delete-offer"
  static let UpdateUserProfile                  = "update-profile"
  static let ChangePassWord                     = "change-password"
  static let Rating                             = "account-rating"
  static let UserOrganizations                  = "userorganizations"
  static let OPPGroupDocumentation              = "oppgroupdocumentation"
  static let OPPPreventionThematics             = "opppreventionthematics"
  static let OPPPreventionDocument              = "opppreventiondocument"
  static let OPPPreventionContentsLast          = "opppreventioncontentslast"
  static let OPPNews                            = "oppnews"
  static let OPPNew                             = "oppnew"
  static let OrganizationDocumentCategories     = "organizationdocumentcategories"
  static let OrganizationDocumentDetail         = "organizationdocumentdetail"
  static let OrganizationAdviser                = "organizationadviser"
  static let OrganizationPreventionCollaborators = "organizationpreventioncollaborators"
  static let OrganizationCollaborator           = "organizationcollaborators"
  static let OrganizationNewsList               = "organizationnewslist"
  static let OrganizationNewsLast               = "organizationnewslast"
  static let OrganizationNews                   = "organizationnews"
  static let OrganizationSites                  = "organizationsites"
  static let OrganizationNotifications          = "organizationnotifications"
  static let SiteActivities                     = "siteactivities"
  static let SiteDocuments                      = "sitedocuments"
  static let SiteDocument                       = "sitedocument"
  static let SiteCollaborators                  = "sitecollaborators"
  static let SiteAdd                            = "siteadd"
  static let SiteUpdate                         = "siteupdate"
  static let SiteEvents                         = "siteevents"
  static let SiteEventType                      = "siteeventtype"
  static let SiteCollaboratorAdd                = "sitecollaboratoradd"
  static let SiteCollaboratorCreateAndAdd       = "sitecollaboratorcreateandadd"
  static let SiteEventAdd                       = "siteeventadd"
  static let SiteWelcomeAdd                     = "sitewelcomeadd"
  static let SiteTallyAdd                       = "sitetallyadd"
  static let SiteTally                          = "sitetally"
  static let SiteEventTypeAdd                   = "siteeventtypeadd"
  
  // Google service
  static let GoogleApiKey                       = "AIzaSyDW9wCUsA0SLVNxEDrn14eyICEJAsJdU3E"
  static let CurrentLocation                    = CLLocation(latitude: 10.8282804, longitude: 106.6939978)
  
  static let GoogleMapApi                       = "https://maps.googleapis.com/maps/api/"
  static let NearbyPlaces                       = "place/nearbysearch/json"
  static let Directions                         = "directions/json"
  
}
