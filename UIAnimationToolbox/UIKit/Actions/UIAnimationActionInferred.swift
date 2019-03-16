//
//  UIAnimationActionInferred.swift
//  UIAnimationToolbox
//
//  Created on 2019/3/16.
//

import UIKit

@available(*, renamed: "UIAnimationAction", message: "Use UIAnimationAction with .inferred style specified instead.")
public class UIAnimationActionInferred: CAAction {
    private let _inferredAction: CAAction
    
    internal init(inferredAction: CAAction) {
        _inferredAction = inferredAction
    }
    
    public convenience init?(layer: CALayer, event: String) {
        if let action = UIView._currentAnimationContext?
            .action(for: layer, forKey: event, style: .inferred)
        {
            self.init(inferredAction: action)
        } else {
            return nil
        }
    }
    
    public static func make(layer: CALayer, event: String) -> CAAction {
        if let action = UIAnimationActionInferred(layer: layer, event: event) {
            return action
        }
        return NSNull()
    }
    
    @objc
    public func run(
        forKey event: String,
        object anObject: Any,
        arguments dict: [AnyHashable : Any]?
        )
    {
        _inferredAction.run(forKey: event, object: anObject, arguments: dict)
    }
}
