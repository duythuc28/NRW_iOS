

import UIKit

extension UILabel {

    // scale font
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let fontName = self.font.fontName
        let fontSize = self.font.pointSize
        self.font = UIFont(name: fontName, size: fontSize * CGFloat(ScaleValue.FONT))
    }
    
    @IBInspectable var localizeKey: String {
        
        get {
            return ""
        } set {
            self.text = NSLocalizedString(newValue, comment: "")
        }
    }
  
  
  /**
   Height for UILabel
   
   - returns: CGFloat
   */
  func heightForLabel() -> CGFloat{
    let label:UILabel = UILabel(frame: CGRectMake(0, 0, self.frame.width, CGFloat.max))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.ByWordWrapping
    label.font = self.font
    label.text = self.text
    
    label.sizeToFit()
    return label.frame.height
  }


}
