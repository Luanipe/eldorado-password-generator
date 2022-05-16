//
//  UIViewControllerExtension.swift
//  PasswordGenerator
//
//  Created by Luan Ipê on 28/04/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    // Função básica que cria um Toast igual ao do Android
    func showToast(message: String) {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 18)
        toastLabel.textColor = .white
        toastLabel.backgroundColor = .black.withAlphaComponent(0.6)
        toastLabel.numberOfLines = 0
        
        let textSize = toastLabel.intrinsicContentSize
        let labelWidth = min(textSize.width, window.frame.width - 40)
        
        toastLabel.frame = CGRect(x: 20, y: window.frame.height - 160, width: labelWidth + 27, height: textSize.height + 17)
        toastLabel.center.x = window.center.x
        toastLabel.layer.cornerRadius = 19
        toastLabel.layer.masksToBounds = true
        
        window.addSubview(toastLabel)
        
        UIView.animate(withDuration: 3.0, animations: {
            toastLabel.alpha = 0
        }) { (_) in
            toastLabel.removeFromSuperview()
        }
    }
}
