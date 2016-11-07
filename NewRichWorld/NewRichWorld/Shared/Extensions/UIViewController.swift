//
//  UIViewControllerExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit

extension UIViewController {
  
  class func instantiateFromStoryboard() -> Self
  {
    return instantiateFromStoryboardHelper(self, storyboardName: "Main")
  }
  
  class func instantiateFromStoryboard(storyboardName: String) -> Self
  {
    return instantiateFromStoryboardHelper(self, storyboardName: storyboardName)
  }
  
  private class func instantiateFromStoryboardHelper<T>(type: T.Type, storyboardName: String) -> T
  {
    var storyboardId = ""
    let components = "\(type.dynamicType)".componentsSeparatedByString(".")
    
    if components.count > 1
    {
      storyboardId = components[0]
    }
    let storyboad = UIStoryboard(name: storyboardName, bundle: nil)
    let controller = storyboad.instantiateViewControllerWithIdentifier(storyboardId) as! T
    
    return controller
  }
}

extension UIViewController {
  /**
   Show view loading
   */
  func showSubLoading() {
    
    // Add loadingView
    let loadingView = UIView(frame: self.view.frame)
    loadingView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
    loadingView.layer.zPosition = 100
    view.addSubview(loadingView)
    
    // add Loading activityIndicatorView
    let loadingActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .White)
    loadingActivityIndicatorView.hidesWhenStopped = true
    loadingActivityIndicatorView.center = loadingView.center
    loadingActivityIndicatorView.startAnimating()
    
    loadingView.addSubview(loadingActivityIndicatorView)
    
  }
  
  /**
   Hide view loading
   */
  func hideSubLoading() {
    if let loadingView = self.view.subviews.last {
      loadingView.removeFromSuperview()
    }
  }
}
