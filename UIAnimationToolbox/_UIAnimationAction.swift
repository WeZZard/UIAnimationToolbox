//
//  _UIAnimationAction.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 1/29/16.
//
//

import UIKit

//MARK: - _UIAnimationAction
internal protocol _UIAnimationAction: CAAction {
    associatedtype Animation: CAAnimation
}

//MARK: - _UIAdditiveAnimationAction
internal class _UIAdditiveAnimationAction<A: CABasicAnimation>:
    _UIAnimationAction
{
    internal typealias Animation = A
    
    internal var pendingAnimation: Animation {
        return action.pendingAnimation
    }
    
    internal let action: CAAdditiveAnimationAction<A>
    
    internal init(layer: CALayer, event: String, pendingAnimation: Animation) {
        action = CAAdditiveAnimationAction(
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
