//
//  UIAnimationAction.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 11/22/15.
//
//

import UIKit

public enum UIAnimationActionStyle {
    /// Get default animations for given layer and event. Does not have
    /// effects on custom properties.
    ///
    case `default`
    
    /// Get inferred animations for given layer and event. Returns an
    /// animation action when the wrapping animation API is supported by
    /// the framework.
    ///
    case inferred
}


public class UIAnimationAction: CAAction {
    internal let _action: CAAction
    
    internal let _style: UIAnimationActionStyle
    
    internal init(action: CAAction, style: UIAnimationActionStyle) {
        _action = action
        _style = style
    }
    
    public convenience init?(
        layer: CALayer,
        event: String,
        style: UIAnimationActionStyle
        )
    {
        if let action = UIView
            ._currentAnimationContext?
            .action(for: layer, forKey: event, style: style)
        {
            self.init(action: action, style: style)
        } else {
            return nil
        }
    }
    
    public static func make(
        layer: CALayer,
        event: String,
        style: UIAnimationActionStyle
        ) -> CAAction
    {
        if let action = UIAnimationAction(
            layer: layer,
            event: event,
            style: style
            )
        {
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
        _action.run(forKey: event, object: anObject, arguments: dict)
    }
}
