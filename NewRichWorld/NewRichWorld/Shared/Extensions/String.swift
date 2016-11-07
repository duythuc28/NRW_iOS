//
//  StringExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/22/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import Foundation
import UIKit

extension String {
  static func className(aClass: AnyClass) -> String {
    return NSStringFromClass(aClass).componentsSeparatedByString(".").last!
  }
  
  func substring(from: Int) -> String {
    return self.substringFromIndex(self.startIndex.advancedBy(from))
  }
  
  var length: Int {
    return self.characters.count
  }
  
  var doubleConverter: Double {
    let converter = NSNumberFormatter()
    converter.decimalSeparator = "."
    converter.maximumFractionDigits = 2
    if let result = converter.numberFromString(self) {
      return result.doubleValue
    } else {
      converter.decimalSeparator = ","
      if let result = converter.numberFromString(self) {
        return result.doubleValue
      }
    }
    return 0
  }
  
  static func random(length: Int = 20) -> String {
    
    let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    var randomString: String = ""
    
    for _ in 0..<length {
      let randomValue = arc4random_uniform(UInt32(base.characters.count))
      randomString += "\(base[base.startIndex.advancedBy(Int(randomValue))])"
    }
    
    return randomString
  }
  
  // get Currency Symbol
  static func currencySymol() -> String {
    let locale = NSLocale.currentLocale()
    let currencyCode = locale.objectForKey(NSLocaleCurrencyCode) as! String
    if currencyCode == "DKK" {
      return "kr"
    } else {
      return "€"
    }
  }
  
  func stringToDate(dateFormat dateFormat: String) -> NSDate? {
    let dateFormater = NSDateFormatter()
    dateFormater.dateFormat = dateFormat
    if let date = dateFormater.dateFromString(self) {
      return date
    }
    return nil
  }
}

extension String {
  func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
    let constraintRect = CGSize(width: width, height: CGFloat.max)
    
    let boundingBox = self.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
    
    return boundingBox.height
  }
  
  func widthWithConstrainedHeight(height: CGFloat, font: UIFont) -> CGFloat {
    let constraintRect = CGSize(width: CGFloat.max, height: height)
    
    let boundingBox = self.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
    
    return boundingBox.width
  }
}


extension String {
  // is valid mail
  func isValidEmail() -> Bool{
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluateWithObject(self)
  }
}

extension String {
  var localized: String {
    return NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: "", comment: "")
  }
}

extension String {
  func isEmptyOrWhitespace() -> Bool {
    if(self.isEmpty) {
      return true
    }
    
    return (self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "")
  }
}

extension String {
  var first: String {
    return String(characters.prefix(1))
  }
  
  var uppercaseFirst: String {
    return first.uppercaseString + String(characters.dropFirst())
  }
}

extension String {
  
  /**
   Check HTML text
   
   - returns: [NSTextCheckingResult] ? HTMLText : NOT HTMLText
   */
  private func isHTMLText() -> [NSTextCheckingResult]? {
    let htmlRegEx = "(<a|<p>|<ul>|<strong>|<li>)"
    do {
      let regularExpression = try NSRegularExpression(pattern: htmlRegEx, options: [])
      let range = NSMakeRange(0, self.characters.count)
      return regularExpression.matchesInString(self, options: [], range: range)
    } catch {
      return nil
    }
  }
  
  /**
   get Attribute string from HTML Text
   
   - returns: NSMutableAttributedString
   */
  mutating func getAttributeFromHTMLText() -> NSMutableAttributedString? {
    // Check HTML text
    if self.isHTMLText() != nil {
      // Config HTML Text if <a href> is exist
      let configHTMLText = self.configHTMLString("(<a href=\\\")", template: "<a href=\"http://opp.extranet.beclood.com")
      // Set text for self
      self = configHTMLText!
      
      // Change Font for HTML text
      let font = UIFont(name: "ArialMT", size: 16.0)
      return self.attributedStringFromHTML(font!)
    }
    return nil
  }
  
  /**
   Get attributeString from HTML Text with Font
   
   - parameter font: Font
   
   - returns: NSMutableAttributedString
   */
  func attributedStringFromHTML(font:UIFont) -> NSMutableAttributedString? {
    let htmlString = "<span style=\"font-family: \(font.fontName); line-height: 24px;font-size: \(font.pointSize); color:rgb(68,68,68)\">" + self + "</span>"
    
    let data = htmlString.dataUsingEncoding(NSUTF8StringEncoding)
    do {
      
      let attributeText = try NSMutableAttributedString(data: data!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
        NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding], documentAttributes: nil)
      return attributeText
      
    } catch let error as NSError {
      print(error.localizedDescription)
    }
    return nil
    
  }
  
  /**
   Replace string
   
   - parameter regex:    NSRegularExpression
   - parameter template: String
   
   - returns: String?
   */
  func configHTMLString(regex: String, template: String) -> String? {
    do {
      let regularExpression = try NSRegularExpression(pattern: regex, options: [])
      let range = NSMakeRange(0, self.characters.count)
      let text = regularExpression.stringByReplacingMatchesInString(self, options: [], range: range, withTemplate: template)
      return text
    } catch let error as NSError {
      print("invalid regex: \(error.localizedDescription)")
      return nil
    }
  }
  
  func checkIsInteger() -> String? {
    let subtextArray = self.componentsSeparatedByString(":")
    if subtextArray.count > 1 {
      if let int = Int(subtextArray[1]) {
        if int == 0 {
          return subtextArray[0]
        }
        return nil
      }
      return nil
    }
    return nil
  }
  
  
}

// MARK: MD5 cryptographic algorithms implemented 
extension String {
  func md5() -> String! {
    let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
    let strLen = CUnsignedInt(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
    let digestLen = Int(CC_MD5_DIGEST_LENGTH)
    let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
    
    CC_MD5(str!, strLen, result)
    
    let hash = NSMutableString()
    for i in 0..<digestLen {
      hash.appendFormat("%02x", result[i])
    }
    
    result.destroy()
    
    return String(format: hash as String)
  }
}

