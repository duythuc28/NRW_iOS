//
//  CTBaseAPI.swift
//  Chantier
//
//  Created by iOS_Devs on 8/18/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import RealmSwift
import SwiftyJSON

class CTBaseAPI {
  class func getList<T: Mappable>(name: String, from result: AnyObject?) -> [T]? {
    if let array = result?[name] as? [AnyObject] {
      return Mapper<T>().mapArray(array)
    }
    return []
  }
  
  class func getOne<T: Mappable>(result: AnyObject?) -> T? {
    if let res = Mapper<T>().map(result) {
      return res
    }
    return nil
  }
}