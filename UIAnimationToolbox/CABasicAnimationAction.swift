//
//  CABasicAnimationAction.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 15/01/2017.
//
//

import QuartzCore

/// Finalize a `CABasicAnimation`'s `toValue`. You may fill its `fromValue` by 
/// yourself, typically before returning the action to a layer in the layer's 
/// delegate method.
///
/// This class may enabled the animation's `isAdditive` property when possible.
///
open class CABasicAnimationAction<Animation: CABasicAnimation>:
    NSObject, CAAction
{
    open unowned var layer: CALayer
    
    open var event: String
    
    open var pendingAnimation: Animation
    
    open var enablesAdditiveness: Bool
    
    open private(set) var hasRewrittenAdditiveness: Bool = false
    
    public init(
        layer: CALayer,
        event: String,
        pendingAnimation: Animation,
        enablesAdditiveness: Bool = true
        )
    {
        assert(pendingAnimation.fromValue != nil, "Expects animation's fromValue not to be nil.")
        assert(!(pendingAnimation.fromValue is NSNull), "Expects animation's fromValue is not an instance of NSNull.")
        self.layer = layer
        self.event = event
        self.pendingAnimation = pendingAnimation
        self.enablesAdditiveness = enablesAdditiveness
    }
    
    open func run(
        forKey event: String,
        object anObject: Any,
        arguments dict: [AnyHashable : Any]?
        )
    {
        // Set to value as non-additive
        pendingAnimation.toValue = layer.value(forKey: event)
        
        // Rewrite `isAdditive`
        if enablesAdditiveness {
            assert((anObject as AnyObject) === layer)
            _rewriteAdditiveness()
        }
        
        pendingAnimation.run(forKey: event, object: anObject, arguments: dict)
    }
    
    private func _rewriteAdditiveness() {
        precondition(pendingAnimation.fromValue != nil && !(pendingAnimation.fromValue is NSNull))
        
        let additivePolicy = type(of: layer).additivePolicy(forKey: event)
        
        switch additivePolicy {
        case .cgRect:
            let fromValue = pendingAnimation.fromValue as! CGRect
            let toValue = layer.value(forKey: event) as! CGRect
            let delta = CGRect(
                x: fromValue.minX - toValue.minX,
                y: fromValue.minY - toValue.minY,
                width: fromValue.width - toValue.width,
                height: fromValue.height - toValue.height
            )
            pendingAnimation.isAdditive = true
            pendingAnimation.fromValue = delta
            pendingAnimation.toValue = CGRect.zero
        case .cgPoint:
            let fromValue = pendingAnimation.fromValue as! CGPoint
            let toValue = layer.value(forKey: event) as! CGPoint
            let delta = CGPoint(
                x: fromValue.x - toValue.x,
                y: fromValue.y - toValue.y
            )
            pendingAnimation.isAdditive = true
            pendingAnimation.fromValue = delta
            pendingAnimation.toValue = CGPoint.zero
        case .cgSize:
            let fromValue = pendingAnimation.fromValue as! CGSize
            let toValue = layer.value(forKey: event) as! CGSize
            let delta = CGSize(
                width: fromValue.width - toValue.width,
                height: fromValue.height - toValue.height
            )
            pendingAnimation.isAdditive = true
            pendingAnimation.fromValue = delta
            pendingAnimation.toValue = CGSize.zero
        case .cgVector:
            let fromValue = pendingAnimation.fromValue as! CGVector
            let toValue = layer.value(forKey: event) as! CGVector
            let delta = CGVector(
                dx: fromValue.dx - toValue.dx,
                dy: fromValue.dy - toValue.dy
            )
            pendingAnimation.isAdditive = true
            pendingAnimation.fromValue = delta
            pendingAnimation.toValue = CGVector.zero
        case .caTransform3D:
            let fromTransform = pendingAnimation.fromValue as! CATransform3D
            let toTransform = layer.value(forKey: event) as! CATransform3D
            if CATransform3DIsAffine(toTransform) && CATransform3DIsAffine(fromTransform) {
                pendingAnimation.isAdditive = true
                let deltaTransform = CATransform3DConcat(CATransform3DInvert(toTransform), fromTransform)
                pendingAnimation.fromValue = deltaTransform
                pendingAnimation.toValue = CATransform3DIdentity
            }
        case .double:
            let fromValue = pendingAnimation.fromValue as! Double
            let toValue = layer.value(forKey: event) as! Double
            let delta = fromValue - toValue
            pendingAnimation.isAdditive = true
            pendingAnimation.fromValue = delta
            pendingAnimation.toValue = Double(0)
        case .float:
            let fromValue = pendingAnimation.fromValue as! Float
            let toValue = layer.value(forKey: event) as! Float
            let delta = fromValue - toValue
            pendingAnimation.isAdditive = true
            pendingAnimation.fromValue = delta
            pendingAnimation.toValue = Float(0)
        case .none:
            break
        }
        hasRewrittenAdditiveness = true
    }
}
