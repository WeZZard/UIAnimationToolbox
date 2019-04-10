//
//  _UIKeyframeAnimationFactory.swift
//  UIAnimationToolbox
//
//  Created on 2019/4/10.
//

import UIKit

internal class _UIKeyframeAnimationFactory<
    A: CAKeyframeAnimation, P: _CAKeyframeAnimationProtocol
    >: _UIAnimationFactory<A, P> where
    P.Animation == A
{
    
}
