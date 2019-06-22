//
//  _UIAnimationInterpolator.swift
//  UIAnimationToolbox
//
//  Created on 2019/3/16.
//

import UIKit

internal class _UIAnimationInterpolator:
    _UIAnimationInterpolatorViewDelegate
{
    private var _impl: _UIAnimationInterpolatorView!
    
    private let _interpolator: (_ progress : CGFloat) -> Void
    
    internal init(interpolator: @escaping (_ progress : CGFloat) -> Void) {
        _interpolator = interpolator
        
        _impl = _UIAnimationInterpolatorView(delegate: self)
        
        UIView.performWithoutAnimation {
            _impl.progress = 0
            _UIAnimationInterpolateWindow.shared.addSubview(self._impl)
        }
        
        CATransaction.withCoordinatedTransaction { (transaction) in
            transaction.completionHandler = {
                let retainedSelf = self
                retainedSelf._impl.removeFromSuperview()
            }
            _impl.progress = 1
        }
    }
    
    internal func animationInterpolatorView(
        _ sender: _UIAnimationInterpolatorView,
        didChangeProgress progress: CGFloat
        )
    {
        _interpolator(progress)
    }
}
