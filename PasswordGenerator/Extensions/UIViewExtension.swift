//
//  UIViewExtension.swift
//  PasswordGenerator
//
//  Created by Luan Ipê on 27/04/22.
//

import UIKit

@IBDesignable
class DesignableView: UIView { }

extension UIView {
    
    /*
     
     Extensão criada para implementar alguns estilos para bordas no Attribute Inspector
     [ Corner Radius, Border Width, Border Color ]
     
    */
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
        
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            }
            else {
                layer.borderColor = nil
            }
        }
    }
}
