//
//  UIAnimationActionDefaultTests.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 2019/3/13.
//

import XCTest

@testable
import UIAnimationToolbox

class UIAnimationActionDefaultTests: XCTestCase {
    // MARK: - Init with Layer Event
    func testInitWithLayerEvent_returnsNil_whenCalledOutsideAnimationBlock() {
        let layer = CALayer()
        let action = UIAnimationActionDefault(layer: layer, event: "bounds.size")
        XCTAssertNil(action)
    }
    
    func testInitWithLayerEvent_returnsNonNil_whenCalledInsideBlockOfBlockAnimation5() {
        let layer = CALayer()
        var action: CAAction!
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            action = UIAnimationActionDefault(layer: layer, event: "bounds.size")
        }, completion: nil)
        XCTAssertNotNil(action)
    }
    
    func testInitWithLayerEvent_returnsNonNil_whenCalledInsideBlockOfBlockAnimation3() {
        let layer = CALayer()
        var action: CAAction!
        UIView.animate(withDuration: 0.3, animations: {
            action = UIAnimationActionDefault(layer: layer, event: "bounds.size")
        }, completion: nil)
        XCTAssertNotNil(action)
    }
    
    func testInitWithLayerEvent_returnsNonNil_whenCalledInsideBlockOfBlockAnimation2() {
        let layer = CALayer()
        var action: CAAction!
        UIView.animate(withDuration: 0.3, animations: {
            action = UIAnimationActionDefault(layer: layer, event: "bounds.size")
        })
        XCTAssertNotNil(action)
    }
    
    func testInitWithLayerEvent_returnsNonNil_whenCalledInsideBlockOfSpringAnimation() {
        let layer = CALayer()
        var action: CAAction!
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
            action = UIAnimationActionDefault(layer: layer, event: "bounds.size")
        }, completion: nil)
        XCTAssertNotNil(action)
    }
    
    // MARK: - Make with Layer Event
    func testMakeLayerEvent_returnsInstanceOfNSNull_whenCalledOutsideAnimationBlock() {
        let layer = CALayer()
        let action = UIAnimationActionDefault.make(layer: layer, event: "bounds.size")
        XCTAssertTrue(action is NSNull)
    }
    
    func testMakeLayerEvent_returnsInstanceOfCAAction_whenCalledInsideBlockOfBlockAnimation5() {
        let layer = CALayer()
        var action: AnyObject!
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            action = UIAnimationActionDefault.make(layer: layer, event: "bounds.size")
        })
        XCTAssertTrue(action is CAAction)
    }
    
    func testMakeLayerEvent_returnsInstanceOfCAAction_whenCalledInsideBlockOfBlockAnimation3() {
        let layer = CALayer()
        var action: AnyObject!
        UIView.animate(withDuration: 0.3, animations: {
            action = UIAnimationActionDefault.make(layer: layer, event: "bounds.size")
        }, completion: nil)
        XCTAssertTrue(action is CAAction)
    }
    
    
    func testMakeLayerEvent_returnsInstanceOfCAAction_whenCalledInsideBlockOfBlockAnimation2() {
        let layer = CALayer()
        var action: AnyObject!
        UIView.animate(withDuration: 0.3, animations: {
            action = UIAnimationActionDefault.make(layer: layer, event: "bounds.size")
        })
        XCTAssertTrue(action is CAAction)
    }
    
    func testMakeLayerEvent_returnsInstanceOfCAAction_whenCalledInsideBlockOfSpringAnimation() {
        let layer = CALayer()
        var action: AnyObject!
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
            action = UIAnimationActionDefault.make(layer: layer, event: "bounds.size")
        }, completion: nil)
        XCTAssertTrue(action is CAAction)
    }
}
