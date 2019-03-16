//
//  _UIAnimationInterpolatorLayer.swift
//  UIAnimationToolbox
//
//  Created on 2019/3/14.
//

import UIKit

internal class _UIAnimationInterpolatorLayer: CALayer {
    @NSManaged
    internal var progress: CGFloat
    
    internal override class func needsDisplay(forKey event: String) -> Bool {
        if event == "progress" {
            return true
        }
        return super.needsDisplay(forKey: event)
    }
}
