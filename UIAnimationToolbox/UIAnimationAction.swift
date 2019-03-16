//
//  UIAnimationAction.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 11/22/15.
//
//

import UIKit

public enum UIAnimationActionStyle {
    /// Get preset animations for given layer and event. May not have
    /// effects on custom properties.
    ///
    case preset
    
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


@available(*, renamed: "UIAnimationAction")
public class UIAnimationActionPreset: CAAction {

    private let _presetAction: CAAction
    
    internal init(presetAction: CAAction) {
        _presetAction = presetAction
    }
    
    public convenience init?(layer: CALayer, event: String) {
        if let action = UIView
            ._currentAnimationContext?
            .presetAction(for: layer, forKey: event)
        {
            self.init(presetAction: action)
        } else {
            return nil
        }
    }
    
    public static func make(layer: CALayer, event: String) -> CAAction {
        if let action = UIAnimationActionPreset(layer: layer, event: event) {
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
        _presetAction.run(forKey: event, object: anObject, arguments: dict)
    }
}


@available(*, renamed: "UIAnimationAction")
public class UIAnimationActionInferred: CAAction {
    private let _inferredAction: CAAction
    
    internal init(inferredAction: CAAction) {
        _inferredAction = inferredAction
    }
    
    public convenience init?(layer: CALayer, event: String) {
        if let action = UIView
            ._currentAnimationContext?
            .inferredAction(for: layer, forKey: event)
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
