//
//  _UIBlockAnimationFactory3.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 2019/3/13.
//

import UIKit

internal class _UIBlockAnimationFactory3:
    _UIBasicAnimationFactory<
    CABasicAnimation,
    _CABasicAnimationPrototype
    >
{
    internal typealias OriginalImplementation = _UIViewAnimateWithDuration3
    
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
                {template = AnimationTemplate()},
                nil
            )
            
            animationTemplate_ = template
        }
        return animationTemplate_
    }
    
    internal init(
        duration: TimeInterval,
        selector: Selector,
        originalImpl: @escaping OriginalImplementation
        )
    {
        _selector = selector
        _originalImpl = originalImpl
        super.init(duration: duration, delay: 0, options: [])
    }
}
