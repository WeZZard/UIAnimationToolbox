//
//  _UIAnimationTemplate.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 1/29/16.
//
//

import UIKit

internal class _UIAnimationTemplate<
    A: CAAnimation, P: _CAAnimationInterconvertible
    >: UIView where A == P.Animation
{
    internal typealias Animation = A
    internal typealias AnimationPrototype = P
    
    internal init() { super.init(frame: UIScreen.main.bounds) }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal lazy var animationPrototype: AnimationPrototype? = {
        let action = self.layer.action(forKey: "opacity")
        guard let applicableAnimation = action as? Animation else {
            return nil
        }
        return AnimationPrototype(animation: applicableAnimation)
    }()
}
