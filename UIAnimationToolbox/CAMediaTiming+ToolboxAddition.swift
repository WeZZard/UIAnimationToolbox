//
//  CAMediaTiming+ToolboxAddition.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 11/20/15.
//
//

import QuartzCore

extension CAMediaTiming {
    /// Return an animation duration deducted by rules described in Apple's Core
    /// Animation Programming Guide.
    public var deducedDuration: CFTimeInterval {
        if self.duration == 0 {
            if let duration = CATransaction.duration {
                return duration
            } else {
                return 0.25
            }
        } else {
            return self.duration
        }
    }
}
