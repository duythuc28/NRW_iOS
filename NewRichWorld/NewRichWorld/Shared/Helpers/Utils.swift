//
//  Utils.swift
//  iOSSwiftCore
//
//  Created by Mobile on 6/17/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation
import UIKit
import ReachabilitySwift

class Utils: NSObject {
  
  static func getRGBA(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
    return UIColor.init(red: r, green: g, blue: b, alpha: a)
  }
  
  static func getRGB(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
    return UIColor.init(red: r, green: g, blue: b, alpha: 1.0)
  }
  
  static func getNavigationController() -> UINavigationController {
    return appDelegate.window?.rootViewController as! UINavigationController
  }
  
  static func getLocalDecimalSeparator() -> String {
    let locale = NSLocale.currentLocale()
    if let comma = locale.objectForKey(NSLocaleDecimalSeparator) as? String {
      return comma
    }
    return ""
  }
  
  static func hourToString(hour:Double) -> String {
    let hours = Int(floor(hour))
    let mins = Int(floor(hour * 60) % 60)
    let secs = Int(floor(hour * 3600) % 60)
    
    return String(format:"%d:%02d", hours, mins, secs)
  }
  
  static func contentAllWhiteSpace(string: String) -> Bool {
    let whiteSpace = NSCharacterSet.whitespaceAndNewlineCharacterSet()
    let trimmed = string.stringByTrimmingCharactersInSet(whiteSpace)
    if trimmed.length == 0 {
      return true
    }
    return false
  }
  
  static func imageByCroppingImage (image: UIImage) -> UIImage {
    
    var imageSize: CGSize?
    if image.size.width > image.size.height {
      imageSize = CGSize(width: image.size.height, height: image.size.height)
    } else {
      imageSize = CGSize(width: image.size.width, height: image.size.width)
    }
    
    let refWidth = image.size.width
    let refHeight = image.size.height
    
    let x = (refWidth - imageSize!.width) / 2
    let y = (refHeight - imageSize!.height) / 2
    
    let cropRect = CGRectMake(x, y, imageSize!.height, imageSize!.width)
    
    let imageRef = CGImageCreateWithImageInRect(image.CGImage, cropRect)
    
    let cropped = UIImage.init(CGImage: imageRef!, scale: 0.0, orientation: image.imageOrientation)
    return cropped
  }
  
  // MARK: Image actions
  /**
   get Path document images
   
   - returns: String?
   */
  static func getPathDocumentImages() -> String? {
    
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    // Get the Document directory path
    let documentDirectorPath:String = paths[0]
    // Create a new path for the new images folder
    let imagesDirectoryPath = documentDirectorPath.stringByAppendingString("/ChantierImages")
    var objcBool:ObjCBool = true
    let isExist = NSFileManager.defaultManager().fileExistsAtPath(imagesDirectoryPath, isDirectory: &objcBool)
    
    if isExist == false {
      do{
        try NSFileManager.defaultManager().createDirectoryAtPath(imagesDirectoryPath, withIntermediateDirectories: true, attributes: nil)
        return imagesDirectoryPath
      }catch{
        print("Something went wrong while creating a new folder")
        return nil
      }
    }
    return imagesDirectoryPath
  }
  
    /**
   Save image
   
   - parameter image: UIImage
   
   - returns: String?
   */
  static func saveImageToDocument(image: UIImage, prefix: String = "") -> String? {
    var imagePath = "\(prefix)\(NSDate().timeIntervalSince1970).jpg"
    let pathDocumentImages = self.getPathDocumentImages()
    if pathDocumentImages != nil {
      let imageName = imagePath
      imagePath = pathDocumentImages!.stringByAppendingString("/\(imagePath)")
      
      let data = UIImageJPEGRepresentation(image, 1.0)
      
      NSFileManager.defaultManager().createFileAtPath(imagePath, contents: data, attributes: nil)
      return imageName
    }
    
    return nil
    
  }
  
  /**
   Load image
   
   - parameter name: String
   
   - returns: UIImage?
   */
  static func loadImageFromDocument(name: String) -> UIImage? {
    let pathDocumentImages = self.getPathDocumentImages()
    if pathDocumentImages != nil {
      let data = NSFileManager.defaultManager().contentsAtPath(pathDocumentImages!.stringByAppendingString("/\(name)"))
      if data != nil {
        return UIImage(data: data!)
      }
      return nil
    }
    return nil
  }
  
  static func loadURLImageFile(imageFile: String) -> NSURL? {
    let path = self.getPathDocumentImages()
    let url = NSURL(fileURLWithPath: path!)
    let pdfPath = url.URLByAppendingPathComponent("\(imageFile)").path
    let fileManager = NSFileManager.defaultManager()
    if fileManager.fileExistsAtPath(pdfPath!) {
      let pathFile = path! as NSString
      let urlFile = NSURL(fileURLWithPath: pathFile.stringByAppendingPathComponent("\(imageFile)"))
      return urlFile
    }
    return nil
  }
  
  /**
   Remove image
   
   - parameter name: String
   
   - returns: Bool
   */
  static func removeImageFromDocument(name: String) -> Bool {
    if name.isEmptyOrWhitespace() {
      return false
    }
    
    let pathDocumentImages = self.getPathDocumentImages()
    if pathDocumentImages != nil {
      let pathImage = pathDocumentImages?.stringByAppendingString("/\(name)")
      do {
        _ = try NSFileManager.defaultManager().removeItemAtPath(pathImage!)
        return true
      } catch {
        return false
      }
    }
    return false
  }
  
  /**
   Get imageNamed from URL
   
   - parameter urlString: String
   
   - returns: String?
   */
  static func getImageNamedFromURL(urlString: String) -> String? {
    let url = NSURL(string: urlString)
    let withoutExtension = url?.URLByDeletingPathExtension
    
    return withoutExtension?.lastPathComponent
  }
  
  // MARK: PDF file
  /**
   Get Path Document PDF files
   
   - returns: String?
   */
  static func getPathDocumentPDFFiles() -> String? {
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    return paths[0]
  }
  
  static func loadURLPDFFile(pdfFile: String) -> NSURL? {
    let path = self.getPathDocumentPDFFiles()
    let url = NSURL(fileURLWithPath: path!)
    let pdfPath = url.URLByAppendingPathComponent("\(pdfFile)").path
    let fileManager = NSFileManager.defaultManager()
    if fileManager.fileExistsAtPath(pdfPath!) {
      let pathFile = path! as NSString
      let urlFile = NSURL(fileURLWithPath: pathFile.stringByAppendingPathComponent("\(pdfFile)"))
      return urlFile
    }
    return nil
  }
  
  static func getPDFFileName(document: CTDocument) -> String {
    
    let themeRemoteId = document.category?.theme?.remoteId
    let siteRemoteId = document.category?.site?.remoteId
    if themeRemoteId != nil {
      let name = "\(themeRemoteId!)".stringByAppendingString("_\(document.remoteId).pdf")
      return name
    }
    else if siteRemoteId != nil {
      let name = "\(siteRemoteId!)".stringByAppendingString("_\(document.remoteId).pdf")
      return name
    }
    return "\(document.remoteId).pdf"
  }
  
  static func getPDFURL(fileName: String) -> NSURL {
    let fileManager = NSFileManager.defaultManager()
    let directoryURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
    let fileUrl = directoryURL.URLByAppendingPathComponent(fileName)
    return fileUrl
  }
  
  static func removePDFFile(fileName: String) -> Bool {
    if fileName.isEmptyOrWhitespace() {
      return false
    }
    let path = self.getPathDocumentPDFFiles()
    let pathFile = path?.stringByAppendingString("/\(fileName)")
    do {
      _ = try NSFileManager.defaultManager().removeItemAtPath(pathFile!)
      return true
    } catch {
      return false
    }
    
  }
  
  static func getFileNamedFromURL(urlString: String) -> String? {
//    let url = NSURL(string: urlString)
//    let withoutExtension = url?.URLByDeletingPathExtension
//    
//    return withoutExtension?.lastPathComponent
    let fileNamed = urlString.componentsSeparatedByString("/")
    return fileNamed.last
  }
  
  static func checkFileExtention(fileNamed: String) -> Int? {
    let array = fileNamed.componentsSeparatedByString(".")
    let count = array.count - 1
    if array[count] != "" {
      let extendFile = array[count]
      if extendFile == "jpg" || extendFile == "png" || extendFile == "jpeg" {
        // Image file
        return 1
      }
      else {
        // Document file
        return 0
      }
    }
    return nil
  }
  
  
  // MARK: SYSTEM
  /**
   Check online/offline
   
   - returns: Bool
   */
  static func hasConnectivity() -> Bool {
    let reachability: Reachability
    do {
      reachability = try Reachability.reachabilityForInternetConnection()
    } catch {
      print("Unable to create Reachability")
      return false
    }
    
    let networkStatus = reachability.currentReachabilityStatus
    return !(networkStatus == .NotReachable)
  }
  
  static func checkURLLink(URLLink: String) -> Bool{
    let urlEncoded = URLLink.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
    let urlRex = "\\w+.jpg|\\w+.pdf|\\w+.png|\\w+.PNG|\\w+.JPG|\\w+[()].jpg"
    if URLLink.rangeOfString(urlRex, options: .RegularExpressionSearch) != nil {
      if let url = NSURL(string: urlEncoded!) {
        return UIApplication.sharedApplication().canOpenURL(url)
      }
      return false
    }
    return false
  }
  
  //MARK: Register Local Notification
  static func isLocalNotificationEnabled() -> Bool {
    if let settings = UIApplication.sharedApplication().currentUserNotificationSettings() {
      return settings.types.contains(.Alert)
    }
    return false
  }
  
  static func registerLocalNotification () {
    UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: .Alert, categories: nil))
  }
  
  static func scheduleLocalNotification(message: String) {
    let notification = UILocalNotification()
    notification.alertBody = message
    notification.fireDate = NSDate()
    UIApplication.sharedApplication().scheduleLocalNotification(notification)
  }
  
  static func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let size = image.size
    
    let widthRatio  = targetSize.width  / image.size.width
    let heightRatio = targetSize.height / image.size.height
    
    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
      newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
    } else {
      newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
    }
    
    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRectMake(0, 0, newSize.width, newSize.height)
    
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 4)
//    UIGraphicsBeginImageContext(newSize)
    image.drawInRect(rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage
  }
  
  static func encodeURL(url: String) -> String? {
    let safeURL = url.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())
    return safeURL
  }
  
  
  static func compareDate(date1: NSDate, date2: NSDate) -> Bool {
    let date1String = date1.dateToString("yyyy-MM-dd")
    let date2String = date2.dateToString("yyyy-MM-dd")
    if date1String == date2String {
      return true
    }
    return false
  }
  
}
