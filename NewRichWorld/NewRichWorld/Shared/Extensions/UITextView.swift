//
//  UITextView.swift
//  iOSSwiftCore
//
//  Created by Mobile on 6/20/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import UIKit

extension UITextView {
    
    // scale font
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let fontName = self.font!.fontName
        let fontSize = self.font!.pointSize
        self.font = UIFont(name: fontName, size: fontSize * CGFloat(ScaleValue.FONT))
    }
    
    @IBInspectable var localizeKey: String {
        
        get {
            return ""
        } set {
            self.text = NSLocalizedString(newValue, comment: "")
        }
    }

    func isAllTextIsWhiteSpace()->Bool{
        return text!
            .stringByTrimmingCharactersInSet(.whitespaceCharacterSet())
            .length == 0
    }
}
