//
//  _UIBasicAnimationFactory.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 03/04/2017.
//
//

import UIKit

internal class _UIBasicAnimationFactory<
    A: CABasicAnimation, P: _CABasicAnimationProtocol
    >: _UIAnimationFactory<A, P> where
    P.Animation == A
{
    internal let options: UIView.AnimationOptions
    
    internal override func inferredAction(
        for layer: CALayer, forKey event: String
        ) -> CAAction?
    {
        if let viewLayerAction = defaultAction(for: layer, forKey: event),
            !(viewLayerAction is NSNull)
        {
            currentAnimationTiming?._shiftAction(viewLayerAction)
            
            return viewLayerAction
        } else {
            let value = layer.value(forKeyPath: event)
            
            let pendingAnimation = Animation()
            
            if configureAnimation(pendingAnimation) {
                
                pendingAnimation.keyPath = event
                
                pendingAnimation.fromValue = value
                
                currentAnimationTiming?._shiftAction(pendingAnimation)
                
                // Layout Subviews
                if options.contains(.layoutSubviews) {
                    layer.setNeedsLayout()
                    layer.layoutIfNeeded()
                }
                
                // Begin from current state
                if options.contains(.beginFromCurrentState) {
                    let presentationLayer = layer.presentation() ?? layer
                    pendingAnimation.fromValue = presentationLayer.value(
                        forKeyPath: event
                    )
                } else {
                    pendingAnimation.fromValue = layer.value(forKeyPath: event)
                }
                
                // Returns the action
                return _UIAnimationFactoryAdditiveAction(
                    layer: layer,
                    event: event,
                    pendingAnimation: pendingAnimation
                )
            }
            
            return nil
        }
     }
    
    internal override func defaultAction(
        for layer: CALayer, forKey event: String
        ) -> CAAction?
    {
        // Set the layer's delegate temporarily to `animationTemplate`
        CATransaction.disablesActions = true
        let originalLayerDelegate = layer.delegate
        layer.delegate = animationTemplate
        CATransaction.disablesActions = false
        
        defer {
            CATransaction.disablesActions = true
            layer.delegate = originalLayerDelegate
            CATransaction.disablesActions = false
        }
        
        if let action = _originalCALayerDelegateActionForLayerForKey(
            animationTemplate,
            #selector(CALayerDelegate.action(for:forKey:)),
            layer,
            event
            )
        {
            currentAnimationTiming?._shiftAction(action)
            
            return action
        }
        
        return nil
     }
    
    internal init(
        duration: TimeInterval,
        delay: TimeInterval,
        options: UIView.AnimationOptions
        )
    {
         self.options = options
         super.init(duration: duration, delay: delay)
     }
}
