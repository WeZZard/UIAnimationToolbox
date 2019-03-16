//
//  _CAInterconvertible.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 1/29/16.
//
//

import QuartzCore

internal protocol _CAMediaTimingProtocol {
    var beginTime: CFTimeInterval { get }
    var timeOffset: TimeInterval { get }
    var repeatCount: Float { get }
    var repeatDuration: CFTimeInterval { get }
    var duration: CFTimeInterval { get }
    var speed: Float { get }
    var autoreverses: Bool { get }
    var fillMode: CAMediaTimingFillMode { get }
}

internal protocol _CAAnimationProtocol: _CAMediaTimingProtocol {
    associatedtype Animation
    
    var isRemovedOnCompletion: Bool { get }
    var timingFunction: CAMediaTimingFunction? { get }
    var delegate: CAAnimationDelegate? { get }
    
    init(animation: Animation)
    func apply(on animation: Animation)
}

internal protocol _CATransitionProtocol: _CAAnimationProtocol { }

internal protocol _CAPropertyAnimationProtocol:
    _CAAnimationProtocol
{
    var cumulative: Bool { get }
    var additive: Bool { get }
}

internal protocol _CABasicAnimationProtocol:
    _CAPropertyAnimationProtocol
{
    
}

internal protocol _CASpringAnimationProtocol:
    _CABasicAnimationProtocol
{
    var mass: CGFloat { get }
    var stiffness: CGFloat { get }
    var damping: CGFloat { get }
    var initialVelocity: CGFloat { get }
}

internal protocol _CAKeyframeAnimationProtocol:
    _CAPropertyAnimationProtocol
{
    var keyTimes: [NSNumber]? { get }
    var timingFunctions: [CAMediaTimingFunction]? { get }
    var calculationMode: CAAnimationCalculationMode { get }
    var rotationMode: CAAnimationRotationMode? { get }
    var tensionValues: [NSNumber]? { get }
    var continuityValues: [NSNumber]? { get }
    var biasValues: [NSNumber]? { get }
}
