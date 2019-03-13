//
//  UICustomAnimationPreprocessAction.swift
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

//MARK: - _UIBasicAnimationAction
internal class _UIBasicAnimationAction<A: CABasicAnimation>:
    _UIAnimationAction
{
    internal typealias Animation = A
    
    internal var pendingAnimation: Animation {
        return action.pendingAnimation
    }
    
    internal let action: CABasicAnimationAction<A>
    
    internal init(layer: CALayer, event: String, pendingAnimation: Animation) {
        action = CABasicAnimationAction(
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
