//
//  UIView+AnimationContext.swift
//  UIAnimationToolbox
//
//  Created on 2019/3/14.
//

import UIKit

extension UIView {
    public static var isInAnimationsBlock: Bool {
        return _currentAnimationContext != nil
    }
    
    public static var currentAnimationContext: UIAnimationContext? {
        return _animationContexts.last
    }
    
    public var currentAnimationContext: UIAnimationContext? {
        return UIView.currentAnimationContext
    }
}
