//
//  UIView+Animate.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 9/14/16.
//
//

import UIKit

// MARK: UIView.animate(withDuration:delay:options:animations:completion:)

internal typealias _UIViewAnimateWithDuration5 = @convention(c) (
    UIView.Type,
    Selector,
    TimeInterval,
    TimeInterval,
    UIView.AnimationOptions,
    @convention(block) () -> Void,
    (@convention(block) (Bool) -> Void)?
    ) -> Void

private var _originalAnimateWithDuration5: _UIViewAnimateWithDuration5!
private let _animateWithDuration5: _UIViewAnimateWithDuration5 = {
    (aClass, aSelector, duration, delay, options, animations,
    completionOrNil) -> Void in
    
    let configureContext = _UIBlockAnimationFactory5(
        duration: duration,
        delay: delay,
        options: options,
        selector: aSelector,
        originalImpl: _originalAnimateWithDuration5
    )
    
    UIView._animationContexts.append(configureContext)
    
    configureContext.prepare()
    
    _originalAnimateWithDuration5(
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

internal func _swizzleAnimateWithDuration5() {
    let sel = #selector(UIView.animate(withDuration:delay:options:animations:completion:))
    let method = class_getClassMethod(UIView.self, sel)!
    let impl = method_getImplementation(method)
    _originalAnimateWithDuration5 = unsafeBitCast(impl, to: _UIViewAnimateWithDuration5.self)
    method_setImplementation(method, unsafeBitCast(_animateWithDuration5, to: IMP.self))
}

// MARK: UIView.animate(withDuration:animations:completion:)

internal typealias _UIViewAnimateWithDuration3 = @convention(c) (
    UIView.Type,
    Selector,
    TimeInterval,
    @convention(block) () -> Void,
    (@convention(block) (Bool) -> Void)?
    ) -> Void

private var _originalAnimateWithDuration3: _UIViewAnimateWithDuration3!
private let _animateWithDuration3: _UIViewAnimateWithDuration3 = {
    (aClass, aSelector, duration, animations, completionOrNil) -> Void in
    
    let configureContext = _UIBlockAnimationFactory3(
        duration: duration,
        selector: aSelector,
        originalImpl: _originalAnimateWithDuration3
    )
    
    UIView._animationContexts.append(configureContext)
    
    configureContext.prepare()
    
    _originalAnimateWithDuration3(
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

internal func _swizzleAnimateWithDuration3() {
    let sel = #selector(UIView.animate(withDuration:animations:completion:))
    let method = class_getClassMethod(UIView.self, sel)!
    let impl = method_getImplementation(method)
    _originalAnimateWithDuration3 = unsafeBitCast(impl, to: _UIViewAnimateWithDuration3.self)
    method_setImplementation(method, unsafeBitCast(_animateWithDuration3, to: IMP.self))
}

// MARK: UIView.animate(withDuration:animations:)

internal typealias _UIViewAnimateWithDuration2 = @convention(c) (
    UIView.Type,
    Selector,
    TimeInterval,
    @convention(block) () -> Void
    ) -> Void

private var _originalAnimateWithDuration2: _UIViewAnimateWithDuration2!
private let _animateWithDuration2: _UIViewAnimateWithDuration2 = {
    (aClass, aSelector, duration, animations) -> Void in
    
    let configureContext = _UIBlockAnimationFactory2(
        duration: duration,
        selector: aSelector,
        originalImpl: _originalAnimateWithDuration2
    )
    
    UIView._animationContexts.append(configureContext)
    
    configureContext.prepare()
    
    _originalAnimateWithDuration2(
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

internal func _swizzleAnimateWithDuration2() {
    let sel = #selector(UIView.animate(withDuration:animations:))
    let method = class_getClassMethod(UIView.self, sel)!
    let impl = method_getImplementation(method)
    _originalAnimateWithDuration2 = unsafeBitCast(impl, to: _UIViewAnimateWithDuration2.self)
    method_setImplementation(method, unsafeBitCast(_animateWithDuration2, to: IMP.self))
}

// MARK: UIView.animate(withDuration:delay:usingSpringWithDamping:initialSpringVelocity:options:animations:completion:)

@available(iOS 9.0, *)
internal typealias _UIViewSpringAnimation = @convention(c) (
    UIView.Type,
    Selector,
    TimeInterval,
    TimeInterval,
    CGFloat,
    CGFloat,
    UIView.AnimationOptions,
    @convention(block) () -> Void,
    (@convention(block) (Bool) -> Void)?
    ) -> Void

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
