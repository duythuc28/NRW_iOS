//
//  CGSize.swift
//  iOSSwiftCore
//
//  Created by iOS_Devs on 7/13/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGSize {
    
    func aspectRatioForWidth(newWidth: CGFloat) -> CGSize {
        let newHeight = height * newWidth / width
        return CGSizeMake(ceil(newWidth), ceil(newHeight))
    }
    
    func aspectRatioForHeight(newHeight: CGFloat) -> CGSize {
        let newWidth = width * newHeight / height
        return CGSizeMake(ceil(newWidth), ceil(newHeight))
    }
    
}
