//
//  UIView+AnimationsTiming.swift
//  UIAnimationToolbox
//
//  Created on 2019/3/14.
//

import UIKit

extension UIView {
    /// Shifts animations timing with `timing` and then returns the given
    /// timing object.
    ///
    @discardableResult
    public class func shiftAnimationsTiming(
        by timing: UIAnimationTiming,
        animations: () -> Void
        ) -> UIAnimationTiming
    {
        _currentAnimationContext?.animationTimings.append(timing)
        animations()
        _currentAnimationContext?.animationTimings.removeLast()
        return timing
    }
    
    /// Shifts animations timing with given timing setup and then returns
    /// the timing object being used in this timing shifting.
    ///
    @discardableResult
    public class func shiftAnimationsTiming(
        beginTime: TimeInterval?=nil,
        duration: TimeInterval?=nil,
        speed: CGFloat?=nil,
        timeOffset: TimeInterval?=nil,
        repeating: UIAnimationTimingRepeating?=nil,
        autoreverses: Bool?=nil,
        fillMode: UIAnimationTimingFillMode?=nil,
        animations: () -> Void
        ) -> UIAnimationTiming
    {
        let animationTiming = UIAnimationTiming(
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
        return animationTiming
    }
}
