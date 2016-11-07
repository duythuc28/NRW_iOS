//
//  CTArrayTransform.swift
//  Chantier
//
//  Created by iOS_Devs on 9/7/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper
import SwiftyJSON

class CTArrayTransform<T:RealmSwift.Object where T:Mappable> : TransformType {
  typealias Object = List<T>
  typealias JSON = Array<AnyObject>
  
  let mapper = Mapper<T>()
  
  func transformFromJSON(value: AnyObject?) -> List<T>? {
    let result = List<T>()
    if let tempArr = value as! Array<AnyObject>? {
      for entry in tempArr {
        let mapper = Mapper<T>()
        if let model : T = mapper.map(entry) {
           result.append(model)
        }
      }
    }
    return result
  }
  
  // transformToJson was replaced with a solution by @zendobk from https://gist.github.com/zendobk/80b16eb74524a1674871
  // to avoid confusing future visitors of this gist. Thanks to @marksbren for pointing this out (see comments of this gist)
  func transformToJSON(value: Object?) -> JSON? {
    var results = [AnyObject]()
    if let value = value {
      for obj in value {
        let json = mapper.toJSON(obj)
        results.append(json)
      }
    }
    return results
  }
}
