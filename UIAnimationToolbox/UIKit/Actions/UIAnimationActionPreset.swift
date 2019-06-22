//
//  UIAnimationActionDefault.swift
//  UIAnimationToolbox
//
//  Created on 2019/3/16.
//

import UIKit

@available(*, renamed: "UIAnimationAction", message: "Use UIAnimationAction with .default style specified instead.")
public class UIAnimationActionDefault: CAAction {
    private let _defaultAction: CAAction
    
    internal init(defaultAction: CAAction) {
        _defaultAction = defaultAction
    }
    
    public convenience init?(layer: CALayer, event: String) {
        if let action = UIView._currentAnimationContext?
            .action(for: layer, forKey: event, style: .default)
        {
            self.init(defaultAction: action)
        } else {
            return nil
        }
    }
    
    public static func make(layer: CALayer, event: String) -> CAAction {
        if let action = UIAnimationActionDefault(layer: layer, event: event) {
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
        _defaultAction.run(forKey: event, object: anObject, arguments: dict)
    }
}
