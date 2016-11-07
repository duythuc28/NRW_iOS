//
//  UIButton.swift
//  iOSSwiftCore
//
//  Created by Mobile on 6/20/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import UIKit

extension UIButton {
  // scale font
  override public func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    let fontName = self.titleLabel!.font.fontName
    let fontSize = self.titleLabel!.font.pointSize
    self.titleLabel!.font = UIFont(name: fontName, size: fontSize * CGFloat(ScaleValue.FONT))
  }

  @IBInspectable var localizeKey: String {

    get {
      return ""
    } set {
      self.setTitle(NSLocalizedString(newValue, comment: ""), forState: .Normal)
    }
  }

  func roundedButton() {
    self.layer.cornerRadius = CGRectGetHeight(self.frame) / 2
  }

  // Add underline for title
  func addUnderlineTitle() {
    let attrs = [
      NSUnderlineStyleAttributeName: 1]

    let buttonAttributedTitleString = NSMutableAttributedString(string: self.titleLabel!.text!, attributes: attrs)
    self.setAttributedTitle(buttonAttributedTitleString, forState: .Normal)

  }

  func setTitleText(title: String) {
    setTitle(title, forState: .Normal)
    setTitle(title, forState: .Highlighted)
  }
}
