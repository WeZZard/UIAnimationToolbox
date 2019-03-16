//
//  UIAnimationActionPreset.swift
//  UIAnimationToolbox
//
//  Created on 2019/3/16.
//

import UIKit

@available(*, renamed: "UIAnimationAction", message: "Use UIAnimationAction with .preset style specified instead.")
public class UIAnimationActionPreset: CAAction {
    
    private let _presetAction: CAAction
    
    internal init(presetAction: CAAction) {
        _presetAction = presetAction
    }
    
    public convenience init?(layer: CALayer, event: String) {
        if let action = UIView._currentAnimationContext?
            .action(for: layer, forKey: event, style: .preset)
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
