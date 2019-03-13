//
//  _UIBlockAnimationFactory5.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 03/04/2017.
//
//

import UIKit

internal class _UIBlockAnimationFactory5:
    _UIBasicAnimationFactory<
    CABasicAnimation,
    _CABasicAnimationPrototype
    >
{
    internal typealias OriginalImplementation = _UIViewAnimateWithDurationDelayOptionsAnimationCompletion
    
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
        options: UIView.AnimationOptions,
        selector: Selector,
        originalImpl: @escaping OriginalImplementation
        )
    {
        _selector = selector
        _originalImpl = originalImpl
        super.init(duration: duration, delay: delay, options: options)
    }
}
