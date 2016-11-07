//
//  UITextField.swift
//  iOSSwiftCore
//
//  Created by Imac on 6/16/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import UIKit

private var maxLengths = [UITextField: Int]()

extension UITextField {
 
    // scale font
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let fontName = self.font!.fontName
        let fontSize = self.font!.pointSize
        self.font = UIFont(name: fontName, size: fontSize * CGFloat(ScaleValue.FONT))
      
        //  Set padding view
//        self.setPaddingView()

      
    }
    
    @IBInspectable var localizeKey: String {
        
        get {
            return ""
        } set {
            self.text = NSLocalizedString(newValue, comment: "")
        }
    }
    
    @IBInspectable var placeholderLocalizeKey: String {
        
        get {
            return ""
        } set {
            self.placeholder = NSLocalizedString(newValue, comment: "")
        }
    }
  
  @IBInspectable var placeHolderColor: UIColor? {
    get {
      return self.placeHolderColor
    }
    set {
      self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSForegroundColorAttributeName: newValue!])
    }
    
  }
  
  
  @IBInspectable var maxLength: Int {
    get {
      
      guard let length = maxLengths[self] else {
        return Int.max
      }
      return length
    }
    set {
      maxLengths[self] = newValue
      
      addTarget(
        self,
        action: #selector(limitLength),
        forControlEvents: UIControlEvents.EditingChanged
      )
    }
  }
    
    @IBInspectable var padding: CGFloat {
        get {
            
           return 0
        }
        set {
            setPaddingView(newValue)
        }
    }
  
  func limitLength(textField: UITextField) {
    
    guard let prospectiveText = textField.text
      where prospectiveText.characters.count > maxLength else {
        return
    }
    
    let selection = selectedTextRange
    
    text = prospectiveText.substringWithRange(
      Range<String.Index>(prospectiveText.startIndex ..< prospectiveText.startIndex.advancedBy(maxLength))
    )
    selectedTextRange = selection
  }
  
  
    func setPaddingView(padding : CGFloat) {
    // Make padding for text field
    let paddingView = UIView(frame: CGRectMake(0, 0, padding, self.frame.size.height))
    
    self.leftView = paddingView
    self.leftViewMode = .Always
    
    self.rightView = paddingView
    self.rightViewMode = .Always
  }
  
  
}