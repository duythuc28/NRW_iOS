//
//  Double.swift
//  Chantier
//
//  Created by Mobile on 9/21/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation


extension Double {
  func convertToIntegerString() -> String {
    let isInteger = floor(self) == self
    if isInteger == true {
      return "\(Int(self))"
    }
   return "\(self)"
  }
}