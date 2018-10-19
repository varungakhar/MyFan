//Button=============================================

import Foundation
import UIKit

@IBDesignable
class ButtonCustom: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
            }
        }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
            }
        }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
            
        }
    }
   
}

//Image=============================================


import UIKit

@IBDesignable
class ImageCustom: UIImageView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = cornerRadius > 0
    }
}
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
        layer.borderWidth = borderWidth
    }
        
    }
    
    @IBInspectable var isRound: Bool = false {
        didSet {
        if(isRound){
        layer.cornerRadius = self.frame.height/2
        layer.masksToBounds = true
            }
        }
    }
    
    @IBInspectable var zIndex: CGFloat = 0 {
        
        didSet {
            layer.zPosition = zIndex
        }
    }

    @IBInspectable var borderColor: UIColor? {
        didSet {
        layer.borderColor = borderColor?.cgColor
            
        }
        
    }
}

//Label=============================================

import Foundation
import UIKit

@IBDesignable
class LabelCustom: UILabel {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
            
        }
        
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        
        didSet {
            
            layer.borderWidth = borderWidth
            
        }
        
    }
    
    @IBInspectable var borderColor: UIColor? {
        
        didSet {
            
            layer.borderColor = borderColor?.cgColor
            
        }
        
    }
    
    
    
    @IBInspectable var isRound: Bool = false {
        
        didSet {
            
            if(isRound){
                
                
                
                layer.cornerRadius = self.frame.height/2
                
                layer.masksToBounds = true
                
            }
            
        }
        
    }
    
    
    
    
    
}







//txtField=============================================



import UIKit

@IBDesignable

class TextFieldCustom: UITextField {
    
    
    
    var bottomBorderSelectedColor:UIColor? = UIColor.white
    
    
    
    var padding: UIEdgeInsets {
        
        get {
            
            return UIEdgeInsets(top: 0, left: paddingValue, bottom: 0, right: paddingValue)
            
        }
        
    }
    
    
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        return UIEdgeInsetsInsetRect(bounds, padding)
        
    }
    
    
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        
        return UIEdgeInsetsInsetRect(bounds, padding)
        
    }
    
    
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        
        return UIEdgeInsetsInsetRect(bounds, padding)
        
    }
    
    
    
    @IBInspectable var editable: Bool = true{
        
        didSet {
            
            self.editable = false
            
        }
        
    }
    
    
    
    @IBInspectable var placeHolderColor:UIColor = .black{
        
        
        
        didSet{
            
            
            
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder!,
                                                            
                                                            attributes: [NSAttributedStringKey.foregroundColor: placeHolderColor])
            
        }
        
        
        
    }
    
    
    
    
    
    
    
    @IBInspectable var paddingValue: CGFloat = 0
    
    
    
    @IBInspectable var bottomValue: CGFloat = 0{
        
        
        
        didSet {
            
            let border = CALayer()
            
            let width = bottomValue
            
            border.borderColor = bottomBorderSelectedColor?.cgColor
            
            border.frame = CGRect(x: 0, y: self.frame.height - width, width:  self.frame.width, height: self.frame.size.height)
            
            
            
            border.borderWidth = width
            
            self.layer.addSublayer(border)
            
            self.layer.masksToBounds = true
            
        }
        
    }
    
    
    
    @IBInspectable var bottomColor: UIColor? = UIColor.white {
        
        didSet {
            
            bottomBorderSelectedColor = self.bottomColor
            
        }
        
    }
    
    
    
    
    
    @IBInspectable var borderColor: UIColor? = UIColor.clear {
        
        didSet {
            
            layer.borderColor = self.borderColor?.cgColor
            
        }
        
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        
        didSet {
            
            layer.borderWidth = self.borderWidth
            
        }
        
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        
        didSet {
            
            layer.cornerRadius = self.cornerRadius
            
            layer.masksToBounds = self.cornerRadius > 0
            
        }
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
    }
    
    
    
    override func draw(_ rect: CGRect) {
        
        self.layer.cornerRadius = self.cornerRadius
        
        self.layer.borderWidth = self.borderWidth
        
        self.layer.borderColor = self.borderColor?.cgColor
        
    }
    
}





//View=============================================



import UIKit



@IBDesignable

class ViewCustom: UIView {
    
    
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        
        didSet {
            
            layer.cornerRadius = cornerRadius
            
            layer.masksToBounds = cornerRadius > 0
            
        }
        
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        
        didSet {
            
            layer.borderWidth = borderWidth
            
        }
        
    }
    
    @IBInspectable var borderColor: UIColor? {
        
        didSet {
            
            layer.borderColor = borderColor?.cgColor
            
        }
        
    }
    
    
    
    @IBInspectable var shadowWidth:CGFloat = 0{
        
        
        
        didSet {
            
            layer.shadowColor = shadowColor.cgColor
            
            layer.shadowOffset = CGSize(width: shadowWidth, height: shadowHeight)
            
            layer.shadowOpacity = shadowOpacity
            
            layer.masksToBounds = false
            
            layer.shadowRadius = shadowRadius
            
        }
        
        
        
    }
    
    @IBInspectable var shadowHeight:CGFloat = 0{
        
        
        
        didSet {
            
            layer.shadowColor = shadowColor.cgColor
            
            layer.shadowOffset = CGSize(width: shadowWidth, height: shadowHeight)
            
            layer.shadowOpacity = shadowOpacity
            
            layer.masksToBounds = false
            
            layer.shadowRadius = shadowRadius
            
        }
        
    }
    
    @IBInspectable var shadowOpacity:Float = 0.0{
        
        
        
        didSet {
            
            layer.shadowColor = shadowColor.cgColor
            
            layer.shadowOffset = CGSize(width: shadowWidth, height: shadowHeight)
            
            layer.shadowOpacity = shadowOpacity
            
            layer.masksToBounds = false
            
            layer.shadowRadius = shadowRadius
            
        }
        
    }
    
    @IBInspectable var shadowColor:UIColor = UIColor.clear{
        
        didSet {
            
            layer.shadowColor = shadowColor.cgColor
            
            layer.shadowOffset = CGSize(width: shadowWidth, height: shadowHeight)
            
            layer.shadowOpacity = shadowOpacity
            
            layer.masksToBounds = false
            
            layer.shadowRadius = shadowRadius
            
        }
        
        
        
    }
    
    
    
    @IBInspectable var shadowRadius:CGFloat = 0.0{
        
        didSet {
            
            layer.shadowColor = shadowColor.cgColor
            
            layer.shadowOffset = CGSize(width: shadowWidth, height: shadowHeight)
            
            layer.shadowOpacity = shadowOpacity
            
            layer.masksToBounds = false
            
            layer.shadowRadius = shadowRadius
            
        }
        
        
        
    }
    
    
    
    @IBInspectable var isRound: Bool = false {
        
        didSet {
            
            if(isRound){
                
                
                
                layer.cornerRadius = self.frame.height/2
                
                layer.masksToBounds = true
                
            }
            
        }
        
    }
    
    
    
    
    
}

