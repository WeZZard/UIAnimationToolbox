//
//  _UIAnimationFactoryAction.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 1/29/16.
//
//

import UIKit

internal protocol _UIAnimationFactoryAction: CAAction {
    associatedtype Animation: CAAnimation
}
