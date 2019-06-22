//
//  _UIAnimationInterpolateWindow.swift
//  UIAnimationToolbox
//
//  Created on 2019/3/16.
//

import UIKit

internal class _UIAnimationInterpolateWindow: UIWindow {
    internal static let shared = _UIAnimationInterpolateWindow(frame: .zero)
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        UIView.performWithoutAnimation {
            windowLevel = UIWindow.Level(-1)
            alpha = 0
            isHidden = false
            isUserInteractionEnabled = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
