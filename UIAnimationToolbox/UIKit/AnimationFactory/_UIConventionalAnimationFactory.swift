//
//  _UIConventionalAnimationFactory.swift
//  UIAnimationToolbox
//
//  Created on 2019/4/10.
//

import UIKit

internal class _UIConventionalAnimationFactory<
    A: CABasicAnimation, P: _CABasicAnimationProtocol
    >: _UIBasicAnimationFactory<A, P> where
    P.Animation == A
{
    
}
