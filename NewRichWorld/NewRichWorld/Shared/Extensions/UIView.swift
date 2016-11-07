//
//  UIView.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 11/5/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        
        get {
            return layer.borderWidth
        }
        
        set {
            
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        
        get {
            return UIColor(CGColor: layer.borderColor!)
        }
        
        set {
            
            layer.borderColor = newValue?.CGColor
        }
    }
    
    class func loadNib<T: UIView>(viewType: T.Type) -> T {
        let className = String.className(viewType)
        return NSBundle(forClass: viewType).loadNibNamed(className, owner: nil, options: nil).first as! T
    }
    
    class func loadNib() -> Self {
        return loadNib(self)
    }
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.nextResponder()
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    func addingDropShadow() {
        let shadowPath = UIBezierPath(rect: self.bounds)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowPath = shadowPath.CGPath
    }
  
  //remove all contrains
  func removeAllConstraints() {
    var list = [NSLayoutConstraint]()
    if let constraints = self.superview?.constraints {
      for c in constraints {
        if c.firstItem as? UIView == self || c.secondItem as? UIView == self {
          list.append(c)
        }
      }
    }
    
    self.superview?.removeConstraints(list)
    self.removeConstraints(self.constraints)
  }
  // Draw border layer
  func leftBorder(color: UIColor = UIColor(hex: "#282828"), weight: CGFloat = 1.0) {
    let layer = CAShapeLayer()
    layer.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: weight, height: self.bounds.height)).CGPath
    layer.fillColor = color.CGColor
    self.layer.addSublayer(layer)
  }
  func rightBorder(color: UIColor = UIColor(hex: "#282828"), weight: CGFloat = 1.0) {
    let layer = CAShapeLayer()
    layer.path = UIBezierPath(rect: CGRect(x: self.bounds.width - 1, y: 0, width: weight, height: self.bounds.height)).CGPath
    layer.fillColor = color.CGColor
    self.layer.addSublayer(layer)
  }
  func topBorder(color: UIColor = UIColor(hex: "#282828"), weight: CGFloat = 1.0) {
    let layer = CAShapeLayer()
    layer.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.bounds.width, height: weight)).CGPath
    layer.fillColor = color.CGColor
    self.layer.addSublayer(layer)
  }
  func bottomBorder(color: UIColor = UIColor(hex: "#282828") , weight: CGFloat = 1.0) {
    let layer = CAShapeLayer()
    layer.path = UIBezierPath(rect: CGRect(x: 0, y: self.bounds.height - 1, width: self.bounds.width, height: weight)).CGPath
    layer.fillColor = color.CGColor
    self.layer.addSublayer(layer)
  }
  
  /**
   Add border Around
   */
  func addBorderAround() {
    self.layer.borderWidth = 1.0
    self.layer.borderColor = UIColor.whiteColor().CGColor
  }

  /**
   *  Animation
   */
  
  func fadeIn(duration: NSTimeInterval = 1.0, delay: NSTimeInterval = 0.0, completion: ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
    UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveEaseIn, animations: {
      self.alpha = 1.0
      }, completion: completion)  }
  
  func fadeOut(duration: NSTimeInterval = 1.0, delay: NSTimeInterval = 0.0, completion: (Bool) -> Void = {(finished: Bool) -> Void in}) {
    UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveEaseIn, animations: {
      self.alpha = 0.0
      }, completion: completion)
  }
}

