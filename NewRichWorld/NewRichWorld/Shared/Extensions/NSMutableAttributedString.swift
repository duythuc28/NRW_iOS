//
//  NSMutableAttributedString.swift
//  Chantier
//
//  Created by iOS_Dev on 8/8/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
  
  func setAsLink(textToFind:String, linkURL:String) -> Bool {
    
    let foundRange = self.mutableString.rangeOfString(textToFind)
    if foundRange.location != NSNotFound {
      self.addAttribute(NSLinkAttributeName, value: linkURL, range: foundRange)
      return true
    }
    return false
  }
  
  func setFontSize(textToFind: String,fontSize: CGFloat, font: String) -> Bool {
    let foundRange = self.mutableString.rangeOfString(textToFind)
    if foundRange.location != NSNotFound {
      self.addAttribute(NSFontAttributeName, value: UIFont(name: font, size: fontSize)!, range: foundRange)
      return true
    }
    return false

  }
  
  func setColorText(textToFind: String, color: UIColor) -> Bool {
    let foundRange = self.mutableString.rangeOfString(textToFind)
    if foundRange.location != NSNotFound {
      self.addAttribute(NSForegroundColorAttributeName, value:  color, range:  foundRange)
      return true
    }
    return false

  }
  
  func addLineModeTruncatingTail() {
    let lineBreak = NSMutableParagraphStyle()
    lineBreak.lineBreakMode = .ByTruncatingTail
    self.addAttribute(NSParagraphStyleAttributeName, value: lineBreak, range: NSMakeRange(0, self.length))
  }
  
}
