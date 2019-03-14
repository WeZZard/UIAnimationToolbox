//
//  _UIBasicAnimationFactory.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 03/04/2017.
//
//

import UIKit

internal class _UIBasicAnimationFactory<
    A: CABasicAnimation, P: _CABasicAnimationInterconvertible
    >: _UIViewAnimationFactory<A, P> where
    P.Animation == A
{
    internal let options: UIView.AnimationOptions
    
    internal override func inferredAction(
        for layer: CALayer, forKey event: String
        ) -> CAAction?
    {
        if let viewLayerAction = presetAction(for: layer, forKey: event),
            !(viewLayerAction is NSNull)
        {
            currentAnimationTiming?.shift(viewLayerAction)
            
            return viewLayerAction
        } else {
            let value = layer.value(forKeyPath: event)
            
            let pendingAnimation = Animation()
            
            if configureAnimation(pendingAnimation) {
                
                pendingAnimation.keyPath = event
                
                pendingAnimation.fromValue = value
                
                currentAnimationTiming?.shift(pendingAnimation)
                
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
                return _UIAdditiveAnimationAction(
                    layer: layer,
                    event: event,
                    pendingAnimation: pendingAnimation
                )
            }
            
            return nil
        }
     }
    
    internal override func presetAction(
        for layer: CALayer, forKey event: String
        ) -> CAAction?
    {
        // Set the layer's delegate temporarily to `animationTemplate`
        CATransaction.setDisableActions(true)
        let originalLayerDelegate = layer.delegate
        layer.delegate = animationTemplate
        CATransaction.setDisableActions(false)
        
        defer {
            CATransaction.setDisableActions(true)
            layer.delegate = originalLayerDelegate
            CATransaction.setDisableActions(false)
        }
        
        if let action = _originalCALayerDelegateActionForLayerForKey(
            animationTemplate,
            #selector(CALayerDelegate.action(for:forKey:)),
            layer,
            event
            )
        {
            currentAnimationTiming?.shift(action)
            
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
