//
//  CATransaction+ToolboxAdditions.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 23/01/2017.
//
//

import QuartzCore

extension CATransaction {
    @objc
    public class var completionHandler: (() -> Void)? {
        @objc(uiat_completionHandler)
        get { return completionBlock() }
        @objc(uiat_setCompletionHandler:)
        set { setCompletionBlock(newValue) }
    }
    
    public class var duration: CFTimeInterval? {
        get {
            if let raw = value(forKey: kCATransactionAnimationDuration) {
                return (raw as! NSNumber).doubleValue
            }
            return nil
        }
        set {
            setValue(newValue, forKey: kCATransactionAnimationDuration)
        }
    }
    
    @objc
    public class var disablesActions: Bool {
        @objc(uiat_disablesActions)
        get { return disableActions() }
        @objc(uiat_setDisablesActions:)
        set { setDisableActions(newValue) }
    }
    
    @objc
    public class var timingFunction: CAMediaTimingFunction? {
        @objc(uiat_timingFunction)
        get { return animationTimingFunction() }
        @objc(uiat_setTimingFunction:)
        set { setAnimationTimingFunction(newValue) }
    }
    
    @objc(uiat_coordinatedTransactionWithBlock:)
    public class func withCoordinatedTransaction(
        _ closure: (_: CATransaction.Type) -> Void
        )
    {
        begin()
        closure(self)
        commit()
    }
}
