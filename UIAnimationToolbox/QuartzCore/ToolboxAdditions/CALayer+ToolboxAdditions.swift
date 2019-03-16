//
//  CALayer+ToolboxAdditions.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 1/2/16.
//
//

import QuartzCore
import ObjectiveC

extension CALayer {
    public func objectiveCEncoding(forKey key: String) -> String? {
        return type(of: self).objectiveCEncoding(forKey: key)
    }
    
    public static func objectiveCEncoding(forKey key: String) -> String? {
        guard let property = class_getProperty(self, key) else {
            return nil
        }
        
        guard let type = property_copyAttributeValue(property, "T") else {
            return nil
        }
        
        guard let nsString = NSString(utf8String: type) else {
            return nil
        }
        
        type.deallocate()
        
        return nsString as String
    }
}

extension CALayer {
    @objc(UIATCAPropertyAnimationAdditivePolicy)
    public enum AdditivePolicy: Int, CustomStringConvertible,
        CustomDebugStringConvertible
    {
        @objc(UIATCAPropertyAnimationAdditivePolicyNone)
        case none
        @objc(UIATCAPropertyAnimationAdditivePolicyCGRect)
        case cgRect
        @objc(UIATCAPropertyAnimationAdditivePolicyCGSize)
        case cgSize
        @objc(UIATCAPropertyAnimationAdditivePolicyCGPoint)
        case cgPoint
        @objc(UIATCAPropertyAnimationAdditivePolicyCGVector)
        case cgVector
        @objc(UIATCAPropertyAnimationAdditivePolicyCATransform3D)
        case caTransform3D
        @objc(UIATCAPropertyAnimationAdditivePolicyFloat)
        case float
        @objc(UIATCAPropertyAnimationAdditivePolicyDouble)
        case double
        
        public var description: String {
            switch self {
            case .none: return "None"
            case .cgRect: return "CGRect"
            case .cgSize: return "CGSize"
            case .cgPoint: return "CGPoint"
            case .cgVector: return "CGVector"
            case .caTransform3D: return "CATransform3D"
            case .float: return "Float"
            case .double: return "Double"
            }
        }
        
        public var debugDescription: String {
            return "<\(type(of: self)); \(description)>"
        }
    }
    
    @objc(uiat_additivePolicyForKey:)
    open class func additivePolicy(forKey event: String)
        -> AdditivePolicy
    {
        switch event {
        case "opacity", "shadowOpacity":
            // `opacity` cannot be additive, perhaps because it's clamped.
            // `shadowOpacity` is also clamped.
            return .none
        default:
            guard let encoding = objectiveCEncoding(forKey: event) else {
                return .none
            }
            
            return additivePolicy(forEncoding: encoding)
        }
    }
    
    @objc(uiat_additivePolicyForEncoding:)
    open class func additivePolicy(forEncoding encoding: String)
        -> AdditivePolicy
    {
        // Don't be scared. Just a manually built automaton.
        
        if encoding.hasPrefix("{") {
            
            let dequeued1 = encoding.dropFirst()
            if dequeued1.hasPrefix("C") {
                let dequeued2 = dequeued1.dropFirst()
                if dequeued2.hasPrefix("G") {
                    let dequeued3 = dequeued2.dropFirst()
                    if dequeued3.hasPrefix("Rect=") {
                        return .cgRect
                    }
                    if dequeued3.hasPrefix("Size=") {
                        return .cgSize
                    }
                    if dequeued3.hasPrefix("Point=") {
                        return .cgPoint
                    }
                    if dequeued3.hasPrefix("Vector=") {
                        return .cgVector
                    }
                }
                if dequeued2.hasPrefix("ATransform3D=") {
                    return .caTransform3D
                }
            }
        }
        
        if encoding == "f" { return .float }
        
        if encoding == "d" { return .double }
        
        return .none
    }
}
