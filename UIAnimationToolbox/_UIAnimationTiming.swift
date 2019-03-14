//
//  _UIAnimationTiming.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 1/29/16.
//
//

import UIKit

internal struct _UIAnimationTiming {
    internal let beginTime: TimeInterval?
    internal let duration: TimeInterval?
    internal let speed: CGFloat?
    internal let timeOffset: TimeInterval?
    internal let repeating: UIAnimationTimingRepeating?
    internal let autoreverses: Bool?
    internal let fillMode: UIAnimationTimingFillMode?
    
    internal init(
        beginTime: TimeInterval?,
        duration: TimeInterval?,
        speed: CGFloat?,
        timeOffset: TimeInterval?,
        repeating: UIAnimationTimingRepeating?,
        autoreverses: Bool?,
        fillMode: UIAnimationTimingFillMode?
        )
    {
        self.beginTime = beginTime
        self.duration = duration
        self.speed = speed
        self.timeOffset = timeOffset
        self.repeating = repeating
        self.autoreverses = autoreverses
        self.fillMode = fillMode
    }
    
    internal func shift(_ action: CAAction) {
        if let mediaTiming = action as? CAMediaTiming {
            _shift(mediaTiming)
        } else if let pendingAnimation
            = (action as? NSObject)?.value(forKey: "pendingAnimation")
                as? CAMediaTiming
        {
            _shift(pendingAnimation)
        } else if action is NSNull {
            // Do nothing
        } else {
            debugPrint("Unable to recognize action: \(action)")
        }
    }
    
    private func _shift(_ mediaTiming: CAMediaTiming) {
        if let beginTime = beginTime {
            mediaTiming.beginTime = beginTime
        }
        if let duration = duration {
            mediaTiming.duration = duration
        }
        if let speed = speed {
            mediaTiming.speed = Float(speed)
        }
        if let timeOffset = timeOffset {
            mediaTiming.timeOffset = timeOffset
        }
        if let repeating = repeating {
            switch repeating {
            case let .byCount(count):
                mediaTiming.repeatCount = Float(count)
            case let .byDuration(duration):
                mediaTiming.repeatDuration = duration
            }
        }
        if let autoreverses = autoreverses {
            mediaTiming.autoreverses = autoreverses
        }
        if let fillMode = fillMode {
            mediaTiming.fillMode = fillMode._caFillMode
        }
    }
}

public enum UIAnimationTimingRepeating {
    case byCount(CGFloat)
    case byDuration(TimeInterval)
}

public enum UIAnimationTimingFillMode: Int {
    case removed
    case backwards
    case forwards
    case both
    
    internal var _caFillMode: CAMediaTimingFillMode {
        switch self {
        case .removed:      return .removed
        case .backwards:    return .backwards
        case .forwards:     return .forwards
        case .both:         return .both
        }
    }
}
