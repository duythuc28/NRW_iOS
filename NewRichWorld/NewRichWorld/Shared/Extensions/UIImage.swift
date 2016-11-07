//
//  UIIMage.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 11/5/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import UIKit

extension UIImage {
    func trim(trimRect trimRect :CGRect) -> UIImage {
        if CGRectContainsRect(CGRect(origin: CGPointZero, size: self.size), trimRect) {
            if let imageRef = CGImageCreateWithImageInRect(self.CGImage, trimRect) {
                return UIImage(CGImage: imageRef)
            }
        }
        
        UIGraphicsBeginImageContextWithOptions(trimRect.size, true, self.scale)
        self.drawInRect(CGRect(x: -trimRect.minX, y: -trimRect.minY, width: self.size.width, height: self.size.height))
        let trimmedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let image = trimmedImage else { return self }
        
        return image
    }
  
  //MARK: resize Image
  func resizedImageAspectRatioWithNewWidth(newWidth: CGFloat) -> UIImage {
    let newSize = self.size.aspectRatioForWidth(newWidth)
    return resizedImageWithSize(newSize)
  }
  
  func resizedImageWithSize(newSize: CGSize) -> UIImage {
    let newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height))
    var newImage: UIImage!
    
    UIGraphicsBeginImageContextWithOptions(newRect.size, false, self.scale);
    self.drawInRect(newRect)
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    let data = UIImageJPEGRepresentation(newImage, 0.7)
    return UIImage(data: data!)!
  }
  
  func resizedImageAspectRatioWithNumberBytes(numberBytes: Int, completeBlock:(image: UIImage) -> Void) {
    let dataImage = UIImageJPEGRepresentation(self, 0.7)
    let newImage = UIImage(data: dataImage!)
    
    let scaleValue = CGFloat((dataImage?.length)!) / (CGFloat(numberBytes) * 0.95)
    let newWidth = newImage!.size.width / scaleValue
    
    completeBlock(image: newImage!.resizedImageAspectRatioWithNewWidth(newWidth))
  }
  
  //MARK: Rotate Image
  public func imageRotatedByDegrees(degrees: CGFloat, flip: Bool) -> UIImage {
    let degreesToRadians: (CGFloat) -> CGFloat = {
      return $0 / 180.0 * CGFloat(M_PI)
    }
    
    // calculate the size of the rotated view's containing box for our drawing space
    let rotatedViewBox = UIView(frame: CGRect(origin: CGPointZero, size: size))
    let t = CGAffineTransformMakeRotation(degreesToRadians(degrees));
    rotatedViewBox.transform = t
    let rotatedSize = rotatedViewBox.frame.size
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize)
    let bitmap = UIGraphicsGetCurrentContext()
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width / 2.0, rotatedSize.height / 2.0);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, degreesToRadians(degrees));
    
    // Now, draw the rotated/scaled image into the context
    var yFlip: CGFloat
    
    if(flip){
      yFlip = CGFloat(-1.0)
    } else {
      yFlip = CGFloat(1.0)
    }
    
    CGContextScaleCTM(bitmap, yFlip, -1.0)
    CGContextDrawImage(bitmap, CGRectMake(-size.width / 2, -size.height / 2, size.width, size.height), CGImage)
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage
  }
  
  // MARK: Reduce size and capacity of image
  // maxSize (byte), default is 500KB
  func reduceCapacity(maxSize: Int = 500*1024, lenght: CGFloat = 600) -> UIImage? {
    var newImage = self
    
    if self.size.height > lenght || self.size.width > lenght {
      let newSize = self.size.height < self.size.width ? self.size.aspectRatioForWidth(lenght) : self.size.aspectRatioForHeight(lenght)
      newImage = self.resizedImageWithSize(newSize)
    }
    
    var dataImage = UIImageJPEGRepresentation(newImage, 1.0)
    
    while dataImage?.length > maxSize {
      dataImage = UIImageJPEGRepresentation(newImage, 0.9)
      
      if let dataImage = dataImage, let image = UIImage(data: dataImage) {
        newImage = image
      } else {
        break
      }
    }
    
    if let dataImage = dataImage {
      return UIImage(data: dataImage)
    } else {
      return nil
    }
  }
  
  convenience init?(base64: String) {
    if let data = NSData(base64EncodedString: base64, options: .IgnoreUnknownCharacters) {
      self.init(data: data)
    } else {
      self.init()
    }
  }
  
  func toBase64(compression: CGFloat = 1.0) -> String? {
    if let imageData = UIImageJPEGRepresentation(self, compression) {
      return imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
    } else {
      return nil
    }
  }
  

  func imageByCroppingImage(size : CGSize) -> UIImage
  {
    let refWidth : CGFloat = CGFloat(CGImageGetWidth(self.CGImage))
    let refHeight : CGFloat = CGFloat(CGImageGetHeight(self.CGImage))
    
    let x = (refWidth - size.width) / 2
    let y = (refHeight - size.height) / 2
    
    let cropRect = CGRectMake(x, y, size.width, size.height)
    let imageRef = CGImageCreateWithImageInRect(self.CGImage, cropRect)
    
    let cropped : UIImage = UIImage(CGImage: imageRef!, scale: 0, orientation: self.imageOrientation)
    
    
    return cropped
  }
}