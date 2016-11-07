//
//  CTSetting.swift
//  Chantier
//
//  Created by iOS_Dev on 9/1/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation
import RealmSwift

class CTSetting: Object {
  dynamic var monday = 0.0
  dynamic var tuesday = 0.0
  dynamic var wednesday = 0.0
  dynamic var thursday = 0.0
  dynamic var friday = 0.0
  dynamic var saturday = 0.0
  dynamic var sunday = 0.0
  dynamic var user: CTUser?
}