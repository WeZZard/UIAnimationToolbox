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
                _swizzleAnimateWithDuration5()
                _swizzleAnimateWithDuration3()
                _swizzleAnimateWithDuration2()
                if #available(iOS 9.0, *) {
                    _swizzleSpringAnimationAPI()
                }
                return true
            }()
        }
        _ = Token.once
    }
}
