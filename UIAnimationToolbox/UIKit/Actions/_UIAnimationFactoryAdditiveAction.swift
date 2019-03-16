//
//  _UIAnimationFactoryAdditiveAction.swift
//  UIAnimationToolbox
//
//  Created on 2019/3/16.
//

import UIKit

internal class _UIAnimationFactoryAdditiveAction<A: CABasicAnimation>:
    _UIAnimationFactoryAction
{
    internal typealias Animation = A
    
    internal var pendingAnimation: Animation {
        return action.pendingAnimation
    }
    
    internal let action: CABasicAnimationAdditiveAction<A>
    
    internal init(layer: CALayer, event: String, pendingAnimation: Animation) {
        action = CABasicAnimationAdditiveAction(
            layer: layer, event: event, pendingAnimation: pendingAnimation
        )
    }
    
    @objc
    internal func run(
        forKey event: String,
        object anObject: Any,
        arguments dict: [AnyHashable : Any]?
        )
    {
        action.run(forKey: event, object: anObject, arguments: dict)
    }
}
