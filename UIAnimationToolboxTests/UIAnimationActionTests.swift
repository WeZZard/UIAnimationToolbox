//
//  UIAnimationActionTests.swift
//  UIAnimationToolbox
//
//  Created on 2019/3/16.
//

import XCTest

@testable
import UIAnimationToolbox

class UIAnimationActionTests: XCTestCase {
    // MARK: - Init with Action and Style
    func testInitWithActionStyle() {
        let internalAction = NSNull()
        let style = UIAnimationActionStyle.inferred
        let action = UIAnimationAction(action: internalAction, style: .inferred)
        XCTAssert(action._action === internalAction)
        XCTAssert(action._style == style)
    }
    
    // MARK: - Init with Layer and Event
    func testInitWithLayerEvent_returnsNil_whenCalledOutsideAnimationBlock() {
        let layer = CALayer()
        let action = UIAnimationAction(layer: layer, event: "bounds.size", style: .default)
        XCTAssertNil(action)
    }
    
    func testInitWithLayerEvent_returnsNonNil_whenCalledInsideBlockOfBlockAnimation5() {
        let layer = CALayer()
        var action: CAAction!
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            action = UIAnimationAction(layer: layer, event: "bounds.size", style: .default)
        }, completion: nil)
        XCTAssertNotNil(action)
    }
    
    func testInitWithLayerEvent_returnsNonNil_whenCalledInsideBlockOfBlockAnimation3() {
        let layer = CALayer()
        var action: CAAction!
        UIView.animate(withDuration: 0.3, animations: {
            action = UIAnimationAction(layer: layer, event: "bounds.size", style: .default)
        }, completion: nil)
        XCTAssertNotNil(action)
    }
    
    func testInitWithLayerEvent_returnsNonNil_whenCalledInsideBlockOfBlockAnimation2() {
        let layer = CALayer()
        var action: CAAction!
        UIView.animate(withDuration: 0.3, animations: {
            action = UIAnimationAction(layer: layer, event: "bounds.size", style: .default)
        })
        XCTAssertNotNil(action)
    }
    
    func testInitWithLayerEvent_returnsNonNil_whenCalledInsideBlockOfSpringAnimation() {
        let layer = CALayer()
        var action: CAAction!
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
            action = UIAnimationAction(layer: layer, event: "bounds.size", style: .default)
        }, completion: nil)
        XCTAssertNotNil(action)
    }
    
    // MARK: - Make with Layer Event
    func testMakeLayerEvent_returnsInstanceOfNSNull_whenCalledOutsideAnimationBlock() {
        let layer = CALayer()
        let action = UIAnimationAction.make(layer: layer, event: "bounds.size", style: .default)
        XCTAssertTrue(action is NSNull)
    }
    
    func testMakeLayerEvent_returnsInstanceOfCAAction_whenCalledInsideBlockOfBlockAnimation5() {
        let layer = CALayer()
        var action: AnyObject!
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            action = UIAnimationAction.make(layer: layer, event: "bounds.size", style: .default)
        })
        XCTAssertTrue(action is CAAction)
    }
    
    func testMakeLayerEvent_returnsInstanceOfCAAction_whenCalledInsideBlockOfBlockAnimation3() {
        let layer = CALayer()
        var action: AnyObject!
        UIView.animate(withDuration: 0.3, animations: {
            action = UIAnimationAction.make(layer: layer, event: "bounds.size", style: .default)
        }, completion: nil)
        XCTAssertTrue(action is CAAction)
    }
    
    func testMakeLayerEvent_returnsInstanceOfCAAction_whenCalledInsideBlockOfBlockAnimation2() {
        let layer = CALayer()
        var action: AnyObject!
        UIView.animate(withDuration: 0.3, animations: {
            action = UIAnimationAction.make(layer: layer, event: "bounds.size", style: .default)
        })
        XCTAssertTrue(action is CAAction)
    }
    
    func testMakeLayerEvent_returnsInstanceOfCAAction_whenCalledInsideBlockOfSpringAnimation() {
        let layer = CALayer()
        var action: AnyObject!
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
            action = UIAnimationAction.make(layer: layer, event: "bounds.size", style: .default)
        }, completion: nil)
        XCTAssertTrue(action is CAAction)
    }
}
