//
//  _CAAnimationPrototypes.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 1/29/16.
//
//

import QuartzCore

internal class _CABasicAnimationPrototype: _CABasicAnimationInterconvertible {
    internal typealias Animation = CABasicAnimation
    
    internal var beginTime: CFTimeInterval
    internal var timeOffset: TimeInterval
    internal var repeatCount: Float
    internal var repeatDuration: CFTimeInterval
    internal var duration: CFTimeInterval
    internal var speed: Float
    internal var autoreverses: Bool
    internal var fillMode: CAMediaTimingFillMode
    
    internal var removedOnCompletion: Bool
    internal var timingFunction: CAMediaTimingFunction?
    internal var delegate: CAAnimationDelegate?
    
    internal var cumulative: Bool
    internal var additive: Bool
    
    internal required init(animation: Animation) {
        beginTime = animation.beginTime
        timeOffset = animation.timeOffset
        repeatCount = animation.repeatCount
        repeatDuration = animation.repeatDuration
        duration = animation.duration
        speed = animation.speed
        autoreverses = animation.autoreverses
        fillMode = animation.fillMode
        removedOnCompletion = animation.isRemovedOnCompletion
        timingFunction = animation.timingFunction
        delegate = animation.delegate
        cumulative = animation.isCumulative
        additive = animation.isAdditive
    }
    
    internal func apply(on animation: Animation) {
        animation.beginTime = beginTime
        animation.timeOffset = timeOffset
        animation.repeatCount = repeatCount
        animation.repeatDuration = repeatDuration
        animation.duration = duration
        animation.speed = speed
        animation.autoreverses = autoreverses
        animation.fillMode = fillMode
        animation.isRemovedOnCompletion = removedOnCompletion
        animation.timingFunction = timingFunction
        animation.delegate = delegate
        animation.isCumulative = cumulative
        animation.isAdditive = additive
    }
}


@available(macOS 10.11, iOS 9.0, *)
internal class _CASpringAnimationPrototype: _CASpringAnimationInterconvertible {
    internal typealias Animation = CASpringAnimation
    
    internal var beginTime: CFTimeInterval
    internal var timeOffset: TimeInterval
    internal var repeatCount: Float
    internal var repeatDuration: CFTimeInterval
    internal var duration: CFTimeInterval
    internal var speed: Float
    internal var autoreverses: Bool
    internal var fillMode: CAMediaTimingFillMode
    
    internal var removedOnCompletion: Bool
    internal var timingFunction: CAMediaTimingFunction?
    internal var delegate: CAAnimationDelegate?
    
    internal var cumulative: Bool
    internal var additive: Bool
    
    internal var mass: CGFloat
    internal var stiffness: CGFloat
    internal var damping: CGFloat
    internal var initialVelocity: CGFloat
    
    internal required init(animation: Animation) {
        beginTime = animation.beginTime
        timeOffset = animation.timeOffset
        repeatCount = animation.repeatCount
        repeatDuration = animation.repeatDuration
        duration = animation.duration
        speed = animation.speed
        autoreverses = animation.autoreverses
        fillMode = animation.fillMode
        removedOnCompletion = animation.isRemovedOnCompletion
        timingFunction = animation.timingFunction
        delegate = animation.delegate
        cumulative = animation.isCumulative
        additive = animation.isAdditive
        mass = animation.mass
        stiffness = animation.stiffness
        damping = animation.damping
        initialVelocity = animation.initialVelocity
    }
    
    internal func apply(on animation: Animation) {
        animation.beginTime = beginTime
        animation.timeOffset = timeOffset
        animation.repeatCount = repeatCount
        animation.repeatDuration = repeatDuration
        animation.duration = duration
        animation.speed = speed
        animation.autoreverses = autoreverses
        animation.fillMode = fillMode
        animation.isRemovedOnCompletion = removedOnCompletion
        animation.timingFunction = timingFunction
        animation.delegate = delegate
        animation.isCumulative = cumulative
        animation.isAdditive = additive
        animation.mass = mass
        animation.stiffness = stiffness
        animation.damping = damping
        animation.initialVelocity = initialVelocity
    }
}


internal  class _CAKeyframeAnimationPrototype:
    _CAKeyframeAnimationInterconvertible
{
    internal typealias Animation = CAKeyframeAnimation
    
    internal var beginTime: CFTimeInterval
    internal var timeOffset: TimeInterval
    internal var repeatCount: Float
    internal var repeatDuration: CFTimeInterval
    internal var duration: CFTimeInterval
    internal var speed: Float
    internal var autoreverses: Bool
    internal var fillMode: CAMediaTimingFillMode
    
    internal var removedOnCompletion: Bool
    internal var timingFunction: CAMediaTimingFunction?
    internal var delegate: CAAnimationDelegate?
    
    internal var cumulative: Bool
    internal var additive: Bool
    
    internal var keyTimes: [NSNumber]?
    internal var timingFunctions: [CAMediaTimingFunction]?
    internal var calculationMode: CAAnimationCalculationMode
    internal var rotationMode: CAAnimationRotationMode?
    internal var tensionValues: [NSNumber]?
    internal var continuityValues: [NSNumber]?
    internal var biasValues: [NSNumber]?
    
    internal required init(animation: Animation) {
        beginTime = animation.beginTime
        timeOffset = animation.timeOffset
        repeatCount = animation.repeatCount
        repeatDuration = animation.repeatDuration
        duration = animation.duration
        speed = animation.speed
        autoreverses = animation.autoreverses
        fillMode = animation.fillMode
        removedOnCompletion = animation.isRemovedOnCompletion
        timingFunction = animation.timingFunction
        delegate = animation.delegate
        cumulative = animation.isCumulative
        additive = animation.isAdditive
        keyTimes = animation.keyTimes
        timingFunctions = animation.timingFunctions
        calculationMode = animation.calculationMode
        rotationMode = animation.rotationMode
        tensionValues = animation.tensionValues
        continuityValues = animation.continuityValues
        biasValues = animation.biasValues
    }
    
    internal func apply(on animation: Animation) {
        animation.beginTime = beginTime
        animation.timeOffset = timeOffset
        animation.repeatCount = repeatCount
        animation.repeatDuration = repeatDuration
        animation.duration = duration
        animation.speed = speed
        animation.autoreverses = autoreverses
        animation.fillMode = fillMode
        animation.isRemovedOnCompletion = removedOnCompletion
        animation.timingFunction = timingFunction
        animation.delegate = delegate
        animation.isCumulative = cumulative
        animation.isAdditive = additive
        animation.keyTimes = keyTimes
        animation.timingFunctions = timingFunctions
        animation.calculationMode = calculationMode
        animation.rotationMode = rotationMode
        animation.tensionValues = tensionValues
        animation.continuityValues = continuityValues
        animation.biasValues = biasValues
    }
}


internal class _CATransitionPrototype: _CATransitionInterconvertible {
    internal typealias Animation = CATransition
    
    internal var beginTime: CFTimeInterval
    internal var timeOffset: TimeInterval
    internal var repeatCount: Float
    internal var repeatDuration: CFTimeInterval
    internal var duration: CFTimeInterval
    internal var speed: Float
    internal var autoreverses: Bool
    internal var fillMode: CAMediaTimingFillMode
    
    internal var removedOnCompletion: Bool
    internal var timingFunction: CAMediaTimingFunction?
    internal var delegate: CAAnimationDelegate?
    
    internal required init(animation: Animation) {
        beginTime = animation.beginTime
        timeOffset = animation.timeOffset
        repeatCount = animation.repeatCount
        repeatDuration = animation.repeatDuration
        duration = animation.duration
        speed = animation.speed
        autoreverses = animation.autoreverses
        fillMode = animation.fillMode
        removedOnCompletion = animation.isRemovedOnCompletion
        timingFunction = animation.timingFunction
        delegate = animation.delegate
    }
    
    internal func apply(on animation: Animation) {
        animation.beginTime = beginTime
        animation.timeOffset = timeOffset
        animation.repeatCount = repeatCount
        animation.repeatDuration = repeatDuration
        animation.duration = duration
        animation.speed = speed
        animation.autoreverses = autoreverses
        animation.fillMode = fillMode
        animation.isRemovedOnCompletion = removedOnCompletion
        animation.timingFunction = timingFunction
        animation.delegate = delegate
    }
}
