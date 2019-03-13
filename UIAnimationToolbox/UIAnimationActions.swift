//
//  UIAnimationActions.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 11/22/15.
//
//

import UIKit

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
    
    public var terminatesActionSearching: Bool {
        return _presetAction is NSNull
    }
}

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
