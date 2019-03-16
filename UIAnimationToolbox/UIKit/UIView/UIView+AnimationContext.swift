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

extension UIView {
    internal static var _animationContexts = [_UIAnimationContextInternal]()
    
    internal static var _currentAnimationContext: _UIAnimationContextInternal? {
        return UIView._animationContexts.last
    }
}
