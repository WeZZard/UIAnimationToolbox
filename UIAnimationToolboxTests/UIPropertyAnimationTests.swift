//
//  UIPropertyAnimationTests.swift
//  UIAnimationToolbox
//
//  Created on 2019/3/16.
//

import XCTest
import UIAnimationToolbox

class UIPropertyAnimationTests: XCTestCase {
    func testPropertyAnimation_hasTheSameDelegateToSystemAnimations() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        let subview = _UIPropertyAnimationView(animatedProperty: 0)
        view.addSubview(subview)
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            subview.animatedProperty = 0.5
            subview.alpha = 0.5
        }) { _ in
            _ = view
        }
        
        XCTAssertNotNil(subview.layer.animation(forKey: "animatedProperty")!)
        XCTAssertNotNil(subview.layer.animation(forKey: "opacity")!)
        let animatedProperty = subview.layer.animation(forKey: "animatedProperty")!
        let opacity = subview.layer.animation(forKey: "opacity")!
        XCTAssert(animatedProperty.delegate === opacity.delegate)
    }
}

private class _UIPropertyAnimationView: UIView {
    var animatedProperty: CGFloat {
        get { return _layer.animatedProperty }
        set { _layer.animatedProperty = newValue }
    }
    
    override class var layerClass: AnyClass {
        return _UIPropertyAnimationLayer.self
    }
    
    var _layer: _UIPropertyAnimationLayer { return layer as! _UIPropertyAnimationLayer }
    
    init(animatedProperty: CGFloat) {
        super.init(frame: .zero)
        self.animatedProperty = animatedProperty
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        animatedProperty = 0
    }
    
    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()!
        UIGraphicsPushContext(ctx)
        UIGraphicsPopContext()
    }
    
    override func action(for layer: CALayer, forKey event: String) -> CAAction? {
        switch event {
        case "animatedProperty":
            return UIAnimationAction(layer: layer, event: event, style: .inferred)
        default:
            return super.action(for: layer, forKey: event)
        }
    }
}

private class _UIPropertyAnimationLayer: CALayer {
    @NSManaged
    var animatedProperty: CGFloat
    
    override class func needsDisplay(forKey key: String) -> Bool {
        switch key {
        case "animatedProperty":    return true
        default:                    return super.needsDisplay(forKey: key)
        }
    }
}
