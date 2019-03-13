//
//  UIViewAnimationOptions+Curve.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 8/26/16.
//
//

import UIKit

extension UIView.AnimationOptions {
    public init(animationCurve: UIView.AnimationCurve) {
        self.init(rawValue: UInt(animationCurve.rawValue) << 16)
    }
}
