//
//  UIView+AnimationTiming.swift
//  UIAnimationToolbox
//
//  Created on 2019/3/14.
//

import UIKit

extension UIView {
    public class func shiftAnimationsTiming(
        _ closure:
        (_ animationTiming: UIAnimationTiming) -> Void
        )
    {
        let timing = _UIAnimationTiming()
        _currentAnimationContext?.animationTimings.append(timing)
        closure(timing)
        _currentAnimationContext?.animationTimings.removeLast()
    }
}
