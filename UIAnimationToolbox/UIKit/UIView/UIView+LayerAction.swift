//
//  UIView+LayerAction.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 9/14/16.
//
//

import UIKit
import ObjectiveC

//MARK: - Swizzle UIView's CALayerDelegate

internal typealias _CALayerDelegateActionForLayerForKey =
    @convention(c) (UIView, Selector, CALayer, String)
    -> CAAction?

internal var _originalCALayerDelegateActionForLayerForKey: _CALayerDelegateActionForLayerForKey {
    return _originalActionForLayerForKey
}

private var _originalActionForLayerForKey : _CALayerDelegateActionForLayerForKey!

private let _actionForLayerForKey: _CALayerDelegateActionForLayerForKey = {
    (aSelf, aSelector, layer, event) -> CAAction? in
    
    if let context = UIView._currentAnimationContext {
        if let originalAction = _originalActionForLayerForKey(
            aSelf,
            aSelector,
            layer,
            event
            )
        {
            if let timing = context.currentAnimationTiming {
                timing._shiftAction(originalAction)
            }
            
            return originalAction
        } else {
            return nil
        }
    } else {
        return _originalActionForLayerForKey(aSelf, aSelector, layer, event)
    }
}

internal func _swizzleCALayerDelegateActionForLayerForKey() {
    struct Token {
        static let once: Bool = {
            let sel = #selector(CALayerDelegate.action(for:forKey:))
            let method = class_getInstanceMethod(UIView.self, sel)!
            let impl = method_getImplementation(method)
            _originalActionForLayerForKey = unsafeBitCast(impl, to: _CALayerDelegateActionForLayerForKey.self)
            method_setImplementation(method, unsafeBitCast(_actionForLayerForKey, to: IMP.self))
            return true
        }()
    }
    _ = Token.once
}
