//
//  NSObject.swift
//  iOSSwiftCore
//
//  Created by Mobile on 7/5/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import UIKit

extension NSObject {
    func JSONDictionary() -> [String : AnyObject] {
        var dict = Dictionary<String, Any>()
        
        let mirror = Mirror(reflecting: self)
        
        for child in mirror.children {
            if let key = child.label {
                dict[key] = child.value
            }
        }
        
        var result = [String: AnyObject]()
        for (key, value) in dict {
            if let v = value as? AnyObject {
                result[key] = v
            }
        }
        
        return result
    }
}
