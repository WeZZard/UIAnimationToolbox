//
//  UIView+AnimatedInterpolator.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 17/02/2017.
//
//

import UIKit

extension UIView {
    // TODO: Add an animated interpolator with identifier.
    public static func addAnimatedInterpolator(
        _ interpolator: @escaping (_ progress : CGFloat) -> Void
        )
    {
        _ = _UIAnimationInterpolator(interpolator: interpolator)
    }
}
