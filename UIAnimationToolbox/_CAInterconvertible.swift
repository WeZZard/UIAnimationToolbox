//
//  _CAInterconvertible.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 1/29/16.
//
//

import QuartzCore

internal protocol _CAMediaTimingInterconvertible {
    var beginTime: CFTimeInterval { get }
    var timeOffset: TimeInterval { get }
    var repeatCount: Float { get }
    var repeatDuration: CFTimeInterval { get }
    var duration: CFTimeInterval { get }
    var speed: Float { get }
    var autoreverses: Bool { get }
    var fillMode: CAMediaTimingFillMode { get }
}

internal protocol _CAAnimationInterconvertible: _CAMediaTimingInterconvertible {
    associatedtype Animation
    
    var isRemovedOnCompletion: Bool { get }
    var timingFunction: CAMediaTimingFunction? { get }
    var delegate: CAAnimationDelegate? { get }
    
    init(animation: Animation)
    func apply(on animation: Animation)
}

internal protocol _CATransitionInterconvertible: _CAAnimationInterconvertible {
    
}

internal protocol _CAPropertyAnimationInterconvertible:
    _CAAnimationInterconvertible
{
    var cumulative: Bool { get }
    var additive: Bool { get }
}

internal protocol _CABasicAnimationInterconvertible:
    _CAPropertyAnimationInterconvertible
{
    
}

internal protocol _CASpringAnimationInterconvertible:
    _CABasicAnimationInterconvertible
{
    var mass: CGFloat { get }
    var stiffness: CGFloat { get }
    var damping: CGFloat { get }
    var initialVelocity: CGFloat { get }
}

internal protocol _CAKeyframeAnimationInterconvertible:
    _CAPropertyAnimationInterconvertible
{
    var keyTimes: [NSNumber]? { get }
    var timingFunctions: [CAMediaTimingFunction]? { get }
    var calculationMode: CAAnimationCalculationMode { get }
    var rotationMode: CAAnimationRotationMode? { get }
    var tensionValues: [NSNumber]? { get }
    var continuityValues: [NSNumber]? { get }
    var biasValues: [NSNumber]? { get }
}
