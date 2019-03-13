//
//  ___UIAnimationToolbox.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 2019/3/13.
//

import Foundation

public class ___UIAnimationToolbox: NSObject {
    public override init() {
        super.init()
        struct Token {
            static var once: Bool = {
                _swizzleCALayerDelegateActionForLayerForKey()
                _swizzleAnimateWithDurationDelayOptionsAnimationCompletion()
                _swizzleAnimateWithDurationAnimationCompletion()
                _swizzleAnimateWithDurationAnimations()
                if #available(iOS 9.0, *) {
                    _swizzleSpringAnimationAPI()
                }
                return true
            }()
        }
        _ = Token.once
    }
}
