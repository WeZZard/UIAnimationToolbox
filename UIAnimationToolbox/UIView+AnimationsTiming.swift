//
//  UIView+AnimationsTiming.swift
//  UIAnimationToolbox
//
//  Created on 2019/3/14.
//

import UIKit

extension UIView {
    public class func shiftAnimationsTiming(
        beginTime: TimeInterval?=nil,
        duration: TimeInterval?=nil,
        speed: CGFloat?=nil,
        timeOffset: TimeInterval?=nil,
        repeating: UIAnimationTimingRepeating?=nil,
        autoreverses: Bool?=nil,
        fillMode: UIAnimationTimingFillMode?=nil,
        animations: () -> Void
        )
    {
        let animationTiming = _UIAnimationTiming(
            beginTime: beginTime,
            duration: duration,
            speed: speed,
            timeOffset: timeOffset,
            repeating: repeating,
            autoreverses: autoreverses,
            fillMode: fillMode
        )
        _currentAnimationContext?.animationTimings.append(animationTiming)
        animations()
        _currentAnimationContext?.animationTimings.removeLast()
    }
}
