//
//  _UIAnimationTiming.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 1/29/16.
//
//

import UIKit

public protocol UIAnimationTiming: class {
    var beginTime: TimeInterval? { get set }
    var duration: TimeInterval? { get set }
    var speed: Float?  { get set }
    var timeOffset: TimeInterval? { get set }
    var repeating: UIAnimationTimingRepeating? { get set }
    var autoreverses: Bool? { get set }
    var fillMode: UIAnimationTimingFillMode? { get set }
}

public enum UIAnimationTimingRepeating {
    case byCount(Float)
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

internal class _UIAnimationTiming: UIAnimationTiming {
    internal var beginTime: CFTimeInterval?
    internal var duration: CFTimeInterval?
    internal var speed: Float?
    internal var timeOffset: CFTimeInterval?
    internal var repeating: UIAnimationTimingRepeating?
    internal var autoreverses: Bool?
    internal var fillMode: UIAnimationTimingFillMode?
    
    internal init() { }
    
    internal func shift(_ action: CAAction) {
        if let animation = action as? CAMediaTiming {
            _shift(animation)
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
            mediaTiming.speed = speed
        }
        if let timeOffset = timeOffset {
            mediaTiming.timeOffset = timeOffset
        }
        if let repeating = repeating {
            switch repeating {
            case let .byCount(count):
                mediaTiming.repeatCount = count
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
