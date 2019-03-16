//
//  _UISpringAnimationFactory.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 03/04/2017.
//
//

import UIKit

@available(iOS 9.0, *)
internal class _UISpringAnimationFactory:
    _UIBasicAnimationFactory<
    CASpringAnimation,
    _CASpringAnimationPrototype
    >
{
    internal let damping: CGFloat
    internal let initialVelocity: CGFloat
    
    internal typealias OriginalImplementation = _UIViewSpringAnimation
    
    private let _selector: Selector
    
    private let _originalImpl: OriginalImplementation
    
    private var animationTemplate_ : AnimationTemplate!
    
    internal override var animationTemplate: AnimationTemplate {
        if animationTemplate_ == nil {
            var template: AnimationTemplate!
            
            _originalImpl(
                UIView.self,
                _selector,
                duration,
                delay,
                damping,
                initialVelocity,
                options,
                {template = AnimationTemplate()},
                nil
            )
            
            animationTemplate_ = template
        }
        return animationTemplate_
    }
    
    internal init(
        duration: TimeInterval,
        delay: TimeInterval,
        damping: CGFloat,
        initialVelocity: CGFloat,
        options: UIView.AnimationOptions,
        selector: Selector,
        originalImpl: @escaping OriginalImplementation
        )
    {
        self.damping = damping
        self.initialVelocity = initialVelocity
        _selector = selector
        _originalImpl = originalImpl
        super.init(duration: duration, delay: delay, options: options)
    }
}
