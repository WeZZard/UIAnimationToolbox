//
//  _UIAnimationFactory.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 03/04/2017.
//
//

import UIKit

internal class _UIAnimationFactory<
    A: CAAnimation, P: _CAAnimationProtocol
    >: NSObject, _UIAnimationContextInternal where P.Animation == A
{
    internal init(duration: TimeInterval, delay: TimeInterval) {
        self.duration = duration
        self.delay = delay
    }
    
    internal let duration: TimeInterval
    
    internal let delay: TimeInterval
    
    internal var animationTimings = [UIAnimationTiming]()
    
    internal var animationType: CAAnimation.Type {
        return Animation.self
    }
    
    /// Prepare the animation template. Call after the context was
    /// initialized and pushed to the the global context stack.
    ///
    /// - Notes: This is a dirty hack. UIKit initiates view-controller
    /// transition alongside animations when the original implementation
    /// of UIKit animation API was fired. But since we have to use an
    /// independent animation block to grab an animation template, the
    /// view-controller transition alongside animations would happen
    /// during generating the animation template. Thus we cannot generate
    /// the animation template in the initializer, else the
    /// view-controller transition alongside animations would not be able
    /// to grab the animation configure context.
    ///
    internal func prepare() {
        _ = animationTemplate
    }
    
    internal var animationTemplate: AnimationTemplate {
        fatalError("Abstract function")
    }
    
    private var _animationPrototype: AnimationPrototype? {
        return animationTemplate.animationPrototype
    }
    
    internal func action(
        for layer: CALayer,
        forKey event: String,
        style: UIAnimationActionStyle
        ) -> CAAction?
    {
        switch style {
        case .inferred: return inferredAction(for: layer, forKey: event)
        case .default:   return defaultAction(for: layer, forKey: event)
        }
    }
    
    internal func inferredAction(
        for layer: CALayer, forKey event: String
        ) -> CAAction?
    {
        fatalError("You should not use this abstract class directly")
    }
    
    internal func defaultAction(
        for layer: CALayer, forKey event: String
        ) -> CAAction?
    {
        fatalError("You should not use this abstract class directly")
    }
    
    internal func createAnimation() -> CAAnimation { return Animation() }
    
    @discardableResult
    internal func configureAnimation(_ animation: CAAnimation) -> Bool {
        if let appropriateAnimation = animation as? Animation,
            let animationPrototype = _animationPrototype
        {
            animationPrototype.apply(on:appropriateAnimation)
            return true
        }
        return false
    }
    
    internal typealias Animation = A
    internal typealias AnimationPrototype = P
    
    internal typealias AnimationTemplate = _UIAnimationTemplate<A, P>
}
