//
//  UIView+AnimationInterpolator.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 17/02/2017.
//
//

import UIKit

extension UIView {
    public static func addAnimationInterpolator(
        _ interpolator: @escaping (_ progress : CGFloat) -> Void
        )
    {
        _ = _UIAnimationInterpolator(interpolator: interpolator)
    }
}
