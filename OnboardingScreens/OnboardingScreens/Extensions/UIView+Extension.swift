//
//  UIView+Extension.swift
//  OnboardingScreens
//
//  Created by BerkH on 24.05.2023.
//

import UIKit

extension UIView{
    @IBInspectable var cornerRadius: CGFloat{
        get{
            return cornerRadius
            
        }
        set{
            self.layer.cornerRadius = newValue
            
        }
    }
}
