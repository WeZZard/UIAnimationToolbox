//
//  _UIAnimationContextInternal.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 1/29/16.
//
//

import UIKit

//MARK: - Definition
internal protocol _UIAnimationContextInternal: UIAnimationContext {
    func inferredAction(for layer: CALayer, forKey event: String) -> CAAction?
    
    func presetAction(for layer: CALayer, forKey event: String) -> CAAction?
    
    func action(for layer: CALayer, forKey event: String, style: UIAnimationActionStyle) -> CAAction?
    
    var animationTimings: [UIAnimationTiming] { get set }
}

extension _UIAnimationContextInternal {
    internal var currentAnimationTiming: UIAnimationTiming? {
        return animationTimings.last
    }
}

extension UIView {
    internal static var _animationContexts = [_UIAnimationContextInternal]()
    
    internal static var _currentAnimationContext: _UIAnimationContextInternal? {
        return UIView._animationContexts.last
    }
}
