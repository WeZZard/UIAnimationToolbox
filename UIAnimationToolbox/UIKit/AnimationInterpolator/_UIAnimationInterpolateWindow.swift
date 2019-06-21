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
        _commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _commonInit()
    }
    
    private func _commonInit() {
        UIView.performWithoutAnimation {
            windowLevel = UIWindow.Level(-1)
            alpha = 0
            isHidden = false
            isUserInteractionEnabled = true
        }
    }
}
