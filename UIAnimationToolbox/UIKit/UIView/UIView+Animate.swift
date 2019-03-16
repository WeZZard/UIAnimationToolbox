//
//  UIView+Animate.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 9/14/16.
//
//

import UIKit

// MARK: UIView.animate(withDuration:delay:options:animations:completion:)
internal typealias _UIViewAnimateWithDurationDelayOptionsAnimationCompletion = @convention(c)
    (UIView.Type, Selector, TimeInterval, TimeInterval,
    UIView.AnimationOptions, () -> Void, ((Bool) -> Void)?)
    -> Void

private var _originalAnimateWithDurationDelayOptionsAnimationCompletion: _UIViewAnimateWithDurationDelayOptionsAnimationCompletion!
private let _animateWithDurationDelayOptionsAnimationCompletion: _UIViewAnimateWithDurationDelayOptionsAnimationCompletion = {
    (aClass, aSelector, duration, delay, options, animations,
    completionOrNil) -> Void in
    
    let configureContext = _UIBlockAnimationFactory5(
        duration: duration,
        delay: delay,
        options: options,
        selector: aSelector,
        originalImpl: _originalAnimateWithDurationDelayOptionsAnimationCompletion
    )
    
    UIView._animationContexts.append(configureContext)
    
    configureContext.prepare()
    
    _originalAnimateWithDurationDelayOptionsAnimationCompletion(
        aClass, aSelector, duration, delay, options, animations,
        completionOrNil
    )
    
    guard let last = UIView._animationContexts.removeLast()
        as? _UIBlockAnimationFactory5,
        last === configureContext
        else
    {
        fatalError("You cannot call UIResponder decendants from non-main thread.")
    }
}

internal func _swizzleAnimateWithDurationDelayOptionsAnimationCompletion() {
    let sel = #selector(UIView.animate(withDuration:delay:options:animations:completion:))
    let method = class_getClassMethod(UIView.self, sel)!
    let impl = method_getImplementation(method)
    _originalAnimateWithDurationDelayOptionsAnimationCompletion = unsafeBitCast(impl, to: _UIViewAnimateWithDurationDelayOptionsAnimationCompletion.self)
    method_setImplementation(method, unsafeBitCast(_animateWithDurationDelayOptionsAnimationCompletion, to: IMP.self))
}

// MARK: UIView.animate(withDuration:animations:completion:)
internal typealias _UIViewAnimateWithDurationAnimationCompletion = @convention(c)
    (UIView.Type, Selector, TimeInterval, () -> Void, ((Bool) -> Void)?)
    -> Void

private var _originalAnimateWithDurationAnimationCompletion: _UIViewAnimateWithDurationAnimationCompletion!
private let _animateWithDurationAnimationCompletion: _UIViewAnimateWithDurationAnimationCompletion = {
    (aClass, aSelector, duration, animations, completionOrNil) -> Void in
    
    let configureContext = _UIBlockAnimationFactory3(
        duration: duration,
        selector: aSelector,
        originalImpl: _originalAnimateWithDurationAnimationCompletion
    )
    
    UIView._animationContexts.append(configureContext)
    
    configureContext.prepare()
    
    _originalAnimateWithDurationAnimationCompletion(
        aClass, aSelector, duration, animations, completionOrNil
    )
    
    guard let last = UIView._animationContexts.removeLast()
        as? _UIBlockAnimationFactory3,
        last === configureContext
        else
    {
        fatalError("You cannot call UIResponder decendants from non-main thread.")
    }
}

internal func _swizzleAnimateWithDurationAnimationCompletion() {
    let sel = #selector(UIView.animate(withDuration:animations:completion:))
    let method = class_getClassMethod(UIView.self, sel)!
    let impl = method_getImplementation(method)
    _originalAnimateWithDurationAnimationCompletion = unsafeBitCast(impl, to: _UIViewAnimateWithDurationAnimationCompletion.self)
    method_setImplementation(method, unsafeBitCast(_animateWithDurationAnimationCompletion, to: IMP.self))
}

// MARK: UIView.animate(withDuration:animations:)
internal typealias _UIViewAnimateWithDurationAnimations = @convention(c)
    (UIView.Type, Selector, TimeInterval, () -> Void)
    -> Void

private var _originalAnimateWithDurationAnimations: _UIViewAnimateWithDurationAnimations!
private let _animateWithDurationAnimations: _UIViewAnimateWithDurationAnimations = {
    (aClass, aSelector, duration, animations) -> Void in
    
    let configureContext = _UIBlockAnimationFactory2(
        duration: duration,
        selector: aSelector,
        originalImpl: _originalAnimateWithDurationAnimations
    )
    
    UIView._animationContexts.append(configureContext)
    
    configureContext.prepare()
    
    _originalAnimateWithDurationAnimations(
        aClass, aSelector, duration, animations
    )
    
    guard let last = UIView._animationContexts.removeLast()
        as? _UIBlockAnimationFactory2,
        last === configureContext
        else
    {
        fatalError("You cannot call UIResponder decendants from non-main thread.")
    }
}

internal func _swizzleAnimateWithDurationAnimations() {
    let sel = #selector(UIView.animate(withDuration:animations:))
    let method = class_getClassMethod(UIView.self, sel)!
    let impl = method_getImplementation(method)
    _originalAnimateWithDurationAnimations = unsafeBitCast(impl, to: _UIViewAnimateWithDurationAnimations.self)
    method_setImplementation(method, unsafeBitCast(_animateWithDurationAnimations, to: IMP.self))
}

// MARK: UIView.animate(withDuration:delay:usingSpringWithDamping:initialSpringVelocity:options:animations:completion:)

@available(iOS 9.0, *)
internal typealias _UIViewSpringAnimation = @convention(c)
    (UIView.Type, Selector, TimeInterval, TimeInterval, CGFloat,
    CGFloat, UIView.AnimationOptions, () -> Void,
    ((Bool) -> Void)?)
    -> Void

@available(iOS 9.0, *)
private var _originalSpringAnimation: _UIViewSpringAnimation!

@available(iOS 9.0, *)
private let _springAnimation: _UIViewSpringAnimation = {
    (aClass, aSelector, duration, delay, damping, initialVelocity,
    options, animations, completionOrNil)
    -> Void in
    
    let configureContext = _UISpringAnimationFactory(
        duration: duration,
        delay: delay,
        damping: damping,
        initialVelocity: initialVelocity,
        options: options,
        selector: aSelector,
        originalImpl: _originalSpringAnimation
    )
    
    UIView._animationContexts.append(configureContext)
    
    configureContext.prepare()
    
    _originalSpringAnimation(
        aClass, aSelector, duration, delay, damping,
        initialVelocity, options, animations, completionOrNil
    )
    
    guard let last = UIView._animationContexts.removeLast()
        as? _UISpringAnimationFactory,
        last === configureContext
        else
    {
        fatalError("You cannot call UIResponder decendants from non-main thread.")
    }
}

@available(iOS 9.0, *)
internal func _swizzleSpringAnimationAPI() {
    let sel = #selector(UIView.animate(withDuration:delay:usingSpringWithDamping:initialSpringVelocity:options:animations:completion:))
    let method = class_getClassMethod(UIView.self, sel)!
    let impl = method_getImplementation(method)
    _originalSpringAnimation = unsafeBitCast(impl, to: _UIViewSpringAnimation.self)
    method_setImplementation(method, unsafeBitCast(_springAnimation, to: IMP.self))
}
