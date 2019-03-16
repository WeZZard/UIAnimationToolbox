//
//  UIAnimationTiming.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 1/29/16.
//
//

import UIKit

public struct UIAnimationTiming {
    public let beginTime: TimeInterval?
    public let duration: TimeInterval?
    public let speed: CGFloat?
    public let timeOffset: TimeInterval?
    public let repeating: UIAnimationTimingRepeating?
    public let autoreverses: Bool?
    public let fillMode: UIAnimationTimingFillMode?
    
    public init(
        beginTime: TimeInterval?=nil,
        duration: TimeInterval?=nil,
        speed: CGFloat?=nil,
        timeOffset: TimeInterval?=nil,
        repeating: UIAnimationTimingRepeating?=nil,
        autoreverses: Bool?=nil,
        fillMode: UIAnimationTimingFillMode?=nil
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
    
    internal func _shiftAction(_ action: CAAction) {
        if let mediaTiming = action as? CAMediaTiming {
            _shiftMediaTiming(mediaTiming)
        } else if let mediaTiming = (action as? NSObject)?
            .value(forKey: "pendingAnimation") as? CAMediaTiming
        {
            _shiftMediaTiming(mediaTiming)
        } else if action is NSNull {
            // Do nothing
        } else {
            debugPrint("Unable to recognize action \(action) while shifting its timing.")
        }
    }
    
    internal func _shiftMediaTiming(_ mediaTiming: CAMediaTiming) {
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


extension UIAnimationTiming {
    /// Makes a delay effect.
    ///
    /// Effects of applying `.delaying(for: 1)` on an animation of
    /// duration of 1 second:
    ///
    /// ```
    ///          | 0s   1s    2s
    /// ---------+--------------
    ///          |
    /// Original | 1---->2
    ///          |
    /// Shifted  |      1---->2
    ///          |
    /// ```
    ///
    public static func makeDelay(delay: TimeInterval) -> UIAnimationTiming {
        return UIAnimationTiming(beginTime: delay, fillMode: .forwards)
    }
    
    /// Makes a hold effect.
    ///
    /// Effects of applying `.hold(until: 1)` on an animation of duration
    /// of 1 second:
    ///
    /// ```
    ///          | 0s   1s    2s
    /// ---------+--------------
    ///          |
    /// Original | 1---->2
    ///          |
    /// Shifted  | 1---->1---->2
    ///          |
    /// ```
    ///
    public static func makeHold(duration: TimeInterval) -> UIAnimationTiming {
        return UIAnimationTiming(beginTime: duration, fillMode: .backwards)
    }
    
    /// Makes a shift effect.
    ///
    /// Effects of applying `.shifting(1)` on an animation of duration of
    /// 2 second:
    ///
    /// ```
    ///          | 0s   1s    2s
    /// ---------+--------------
    ///          |
    /// Original | 1---->2---->3
    ///          |
    /// Shifted  | 2---->3---->1
    ///          |
    /// ```
    ///
    public static func makeShift(timeOffset: TimeInterval) -> UIAnimationTiming {
        return UIAnimationTiming(timeOffset: timeOffset)
    }
    
    /// Make a speed effect. Negative value is allowed.
    ///
    /// Effects of applying `.speeding(at: 2)` on an animation of
    /// duration of 2 second:
    ///
    /// ```
    ///          | 0s   1s    2s
    /// ---------+--------------
    ///          |
    /// Original | 1---->2---->3
    ///          |
    /// Shifted  | 1->2->3
    ///          |
    /// ```
    ///
    /// - Notes: This function accepts negative `speed` value which causes
    /// the animation played reversely.
    ///
    public static func makeSpeed(speed: CGFloat) -> UIAnimationTiming {
        return UIAnimationTiming(speed: speed)
    }
    
    /// Makes a speed effect.
    ///
    /// Effects of applying `.autoreversing(at: true)` on an animation of
    /// duration of 1 second:
    ///
    /// ```
    ///          | 0s   1s    2s
    /// ---------+--------------
    ///          |
    /// Original | 1---->2
    ///          |
    /// Shifted  | 1---->2---->1
    ///          |
    /// ```
    ///
    public static func makeAutoreversing(autoreverses: Bool) -> UIAnimationTiming {
        return UIAnimationTiming(autoreverses: autoreverses)
    }
    
    /// Makes a repeat-by-count effect. Fractional value is allowed.
    ///
    /// Effects of applying `.repeating(byCount: 1)` on an animation of
    /// duration of 1 second:
    ///
    /// ```
    ///          | 0s    1s     2s
    /// ---------+----------------
    ///          |
    /// Original | 1---->2
    ///          |
    /// Shifted  | 1---->2,1---->2
    ///          |
    /// ```
    ///
    public static func makeRepetition(count: CGFloat) -> UIAnimationTiming {
        return UIAnimationTiming(repeating: .byCount(count))
    }
    
    /// Makes a repeat-by-duration effect.
    ///
    /// Effects of applying `.repeating(byDuration: 1)` on an animation of
    /// duration of 2 second:
    ///
    /// ```
    ///          | 0s   1s    2s
    /// ---------+---------------
    ///          |
    /// Original | 1---->2---->3
    ///          |
    /// Shifted  | 1---->2
    ///          |
    /// ```
    ///
    public static func makeRepetition(duration: TimeInterval) -> UIAnimationTiming {
        return UIAnimationTiming(repeating: .byDuration(duration))
    }
}


extension UIAnimationTiming {
    public func delaying(for time: TimeInterval) -> UIAnimationTiming {
        return UIAnimationTiming(
            beginTime: time,
            duration: duration,
            speed: speed,
            timeOffset: timeOffset,
            repeating: repeating,
            autoreverses: autoreverses,
            fillMode: .forwards
        )
    }
    
    public func holding(until time: TimeInterval) -> UIAnimationTiming {
        return UIAnimationTiming(
            beginTime: time,
            duration: duration,
            speed: speed,
            timeOffset: timeOffset,
            repeating: repeating,
            autoreverses: autoreverses,
            fillMode: .backwards
        )
    }
    
    public func speeding(_ at: CGFloat) -> UIAnimationTiming {
        return UIAnimationTiming(
            beginTime: beginTime,
            duration: duration,
            speed: speed,
            timeOffset: timeOffset,
            repeating: repeating,
            autoreverses: autoreverses,
            fillMode: fillMode
        )
    }
    
    public func shifting( timeOffset: TimeInterval) -> UIAnimationTiming {
        return UIAnimationTiming(
            beginTime: beginTime,
            duration: duration,
            speed: speed,
            timeOffset: timeOffset,
            repeating: repeating,
            autoreverses: autoreverses,
            fillMode: fillMode
        )
    }
    
    public func repeating(byCount count: CGFloat) -> UIAnimationTiming {
        return UIAnimationTiming(
            beginTime: beginTime,
            duration: duration,
            speed: speed,
            timeOffset: timeOffset,
            repeating: .byCount(count),
            autoreverses: autoreverses,
            fillMode: fillMode
        )
    }
    
    public func repeating(byDuration duration: TimeInterval) -> UIAnimationTiming {
        return UIAnimationTiming(
            beginTime: beginTime,
            duration: duration,
            speed: speed,
            timeOffset: timeOffset,
            repeating: .byDuration(duration),
            autoreverses: autoreverses,
            fillMode: fillMode
        )
    }
    
    public func autoreversing(_ autoreverses: Bool) -> UIAnimationTiming {
        return UIAnimationTiming(
            beginTime: beginTime,
            duration: duration,
            speed: speed,
            timeOffset: timeOffset,
            repeating: repeating,
            autoreverses: autoreverses,
            fillMode: fillMode
        )
    }
}


extension UIAnimationTiming {
    public func settingBeginTime(_ beginTime: TimeInterval) -> UIAnimationTiming {
        return UIAnimationTiming(
            beginTime: beginTime,
            duration: duration,
            speed: speed,
            timeOffset: timeOffset,
            repeating: repeating,
            autoreverses: autoreverses,
            fillMode: fillMode
        )
    }
    
    public func settingDuration(_ duration: TimeInterval) -> UIAnimationTiming {
        return UIAnimationTiming(
            beginTime: beginTime,
            duration: duration,
            speed: speed,
            timeOffset: timeOffset,
            repeating: repeating,
            autoreverses: autoreverses,
            fillMode: fillMode
        )
    }
    
    public func settingSpeed(_ speed: CGFloat) -> UIAnimationTiming {
        return UIAnimationTiming(
            beginTime: beginTime,
            duration: duration,
            speed: speed,
            timeOffset: timeOffset,
            repeating: repeating,
            autoreverses: autoreverses,
            fillMode: fillMode
        )
    }
    
    public func settingTimeOffset(_ timeOffset: TimeInterval) -> UIAnimationTiming {
        return UIAnimationTiming(
            beginTime: beginTime,
            duration: duration,
            speed: speed,
            timeOffset: timeOffset,
            repeating: repeating,
            autoreverses: autoreverses,
            fillMode: fillMode
        )
    }
    
    public func settingRepeating(_ repeating: UIAnimationTimingRepeating) -> UIAnimationTiming {
        return UIAnimationTiming(
            beginTime: beginTime,
            duration: duration,
            speed: speed,
            timeOffset: timeOffset,
            repeating: repeating,
            autoreverses: autoreverses,
            fillMode: fillMode
        )
    }
    
    public func settingAutoreverses(_ autoreverses: Bool) -> UIAnimationTiming {
        return UIAnimationTiming(
            beginTime: beginTime,
            duration: duration,
            speed: speed,
            timeOffset: timeOffset,
            repeating: repeating,
            autoreverses: autoreverses,
            fillMode: fillMode
        )
    }
    
    public func settingFillMode(_ fillMode: UIAnimationTimingFillMode) -> UIAnimationTiming {
        return UIAnimationTiming(
            beginTime: beginTime,
            duration: duration,
            speed: speed,
            timeOffset: timeOffset,
            repeating: repeating,
            autoreverses: autoreverses,
            fillMode: fillMode
        )
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
