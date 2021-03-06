//
//  _UIAnimationInterpolatorView.swift
//  UIAnimationToolbox
//
//  Created on 2019/3/16.
//

import UIKit

internal protocol _UIAnimationInterpolatorViewDelegate: class {
    func animationInterpolatorView(
        _ sender: _UIAnimationInterpolatorView,
        didChangeProgress progress: CGFloat
    )
}


internal class _UIAnimationInterpolatorView: UIView {
    internal unowned let delegate: _UIAnimationInterpolatorViewDelegate
    
    internal init(delegate: _UIAnimationInterpolatorViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        self.delegate = aDecoder.decodeObject(forKey: "delegate") as! _UIAnimationInterpolatorViewDelegate
        super.init(coder: aDecoder)
    }
    
    internal override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(delegate, forKey: "delegate")
    }
    
    internal var progress: CGFloat {
        get { return _layer.progress }
        set { _layer.progress = newValue }
    }
    
    private var _layer: _UIAnimationInterpolatorLayer {
        return layer as! _UIAnimationInterpolatorLayer
    }
    
    internal override func action(for layer: CALayer, forKey event: String)
        -> CAAction?
    {
        if UIView.isInAnimationsBlock && UIView.areAnimationsEnabled {
            if layer === layer && event == "progress" {
                return UIAnimationActionInferred(layer: layer, event: event)
            }
        }
        return super.action(for: layer, forKey: event)
    }
    
    internal override class var layerClass: AnyClass {
        return _UIAnimationInterpolatorLayer.self
    }
    
    internal func animationInterpolatorLayer(
        _ sender: _UIAnimationInterpolatorLayer,
        didChangeProgress progress: CGFloat
        )
    {
        delegate.animationInterpolatorView(
            self, didChangeProgress: CGFloat(sender.opacity)
        )
    }
    
    internal override func display(_ layer: CALayer) {
        let interpolatorLayer = layer as! _UIAnimationInterpolatorLayer
        guard let presentationLayer = interpolatorLayer.presentation()
            else { return }
        
        let progress = presentationLayer.progress
        
        delegate.animationInterpolatorView(self, didChangeProgress: progress)
    }
}
