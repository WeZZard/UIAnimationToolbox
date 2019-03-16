//
//  _UIAnimationContextInternal.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 1/29/16.
//
//

import UIKit

internal protocol _UIAnimationContextInternal: UIAnimationContext {
    func action(for layer: CALayer, forKey event: String, style: UIAnimationActionStyle) -> CAAction?
    
    var animationTimings: [UIAnimationTiming] { get set }
}

extension _UIAnimationContextInternal {
    internal var currentAnimationTiming: UIAnimationTiming? {
        return animationTimings.last
    }
}
