//
//  UIAnimationTimingTests.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 2019/3/13.
//

import XCTest
import UIAnimationToolbox

class UIAnimationTimingTests: XCTestCase {
    func testShiftAnimationsTiming_works_inAnimateWithDurationAnimations() {
        let parent = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let child = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        parent.addSubview(child)
        
        UIView.animate(withDuration: 0.3, animations: {
            parent.bounds = CGRect(x: 0, y: 0, width: 200, height: 200)
            UIView.shiftAnimationsTiming(timeOffset: 0.3, animations: {
                child.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
            })
        })
        
        let parentAnimationBoundsSize = parent.layer.animation(forKey: "bounds.size")! as! CABasicAnimation
        XCTAssertTrue(parentAnimationBoundsSize.isAdditive)
        XCTAssertEqual(parentAnimationBoundsSize.fromValue as! NSValue?, NSValue(cgSize: CGSize(width: -100, height: -100)))
        XCTAssertEqual(parentAnimationBoundsSize.toValue as! NSValue?, NSValue(cgSize: CGSize(width: 0, height: 0)))
        XCTAssertEqual(parentAnimationBoundsSize.timeOffset, 0)
        
        let childAnimationBoundsSize = child.layer.animation(forKey: "bounds.size")! as! CABasicAnimation
        XCTAssertTrue(childAnimationBoundsSize.isAdditive)
        XCTAssertEqual(childAnimationBoundsSize.fromValue as! NSValue?, NSValue(cgSize: CGSize(width: 50, height: 50)))
        XCTAssertEqual(childAnimationBoundsSize.toValue as! NSValue?, NSValue(cgSize: CGSize(width: 0, height: 0)))
        XCTAssertEqual(childAnimationBoundsSize.timeOffset, 0.3)
    }
    
    func testShiftAnimationsTiming_works_inAnimateWithDurationAnimationsCompletion() {
        let parent = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let child = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        parent.addSubview(child)
        
        UIView.animate(withDuration: 0.3, animations: {
            parent.bounds = CGRect(x: 0, y: 0, width: 200, height: 200)
            UIView.shiftAnimationsTiming(timeOffset: 0.3, animations: {
                child.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
            })
        }, completion: nil)
        
        let parentAnimationBoundsSize = parent.layer.animation(forKey: "bounds.size")! as! CABasicAnimation
        XCTAssertTrue(parentAnimationBoundsSize.isAdditive)
        XCTAssertEqual(parentAnimationBoundsSize.fromValue as! NSValue?, NSValue(cgSize: CGSize(width: -100, height: -100)))
        XCTAssertEqual(parentAnimationBoundsSize.toValue as! NSValue?, NSValue(cgSize: CGSize(width: 0, height: 0)))
        XCTAssertEqual(parentAnimationBoundsSize.timeOffset, 0)
        
        let childAnimationBoundsSize = child.layer.animation(forKey: "bounds.size")! as! CABasicAnimation
        XCTAssertTrue(childAnimationBoundsSize.isAdditive)
        XCTAssertEqual(childAnimationBoundsSize.fromValue as! NSValue?, NSValue(cgSize: CGSize(width: 50, height: 50)))
        XCTAssertEqual(childAnimationBoundsSize.toValue as! NSValue?, NSValue(cgSize: CGSize(width: 0, height: 0)))
        XCTAssertEqual(childAnimationBoundsSize.timeOffset, 0.3)
    }

    func testShiftAnimationsTiming_works_inAnimateWithDurationDelayOptionsAnimationsCompletion() {
        let parent = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let child = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        parent.addSubview(child)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            parent.bounds = CGRect(x: 0, y: 0, width: 200, height: 200)
            UIView.shiftAnimationsTiming(timeOffset: 0.3, animations: {
                child.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
            })
        })
        
        let parentAnimationBoundsSize = parent.layer.animation(forKey: "bounds.size")! as! CABasicAnimation
        XCTAssertTrue(parentAnimationBoundsSize.isAdditive)
        XCTAssertEqual(parentAnimationBoundsSize.fromValue as! NSValue?, NSValue(cgSize: CGSize(width: -100, height: -100)))
        XCTAssertEqual(parentAnimationBoundsSize.toValue as! NSValue?, NSValue(cgSize: CGSize(width: 0, height: 0)))
        XCTAssertEqual(parentAnimationBoundsSize.timeOffset, 0)
        
        let childAnimationBoundsSize = child.layer.animation(forKey: "bounds.size")! as! CABasicAnimation
        XCTAssertTrue(childAnimationBoundsSize.isAdditive)
        XCTAssertEqual(childAnimationBoundsSize.fromValue as! NSValue?, NSValue(cgSize: CGSize(width: 50, height: 50)))
        XCTAssertEqual(childAnimationBoundsSize.toValue as! NSValue?, NSValue(cgSize: CGSize(width: 0, height: 0)))
        XCTAssertEqual(childAnimationBoundsSize.timeOffset, 0.3)
    }
    
    func testShiftAnimationsTiming_works_inSpringAnimations() {
        let parent = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let child = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        parent.addSubview(child)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
            parent.bounds = CGRect(x: 0, y: 0, width: 200, height: 200)
            UIView.shiftAnimationsTiming(timeOffset: 0.3, animations: {
                child.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
            })
        }, completion: nil)
        
        let parentAnimationBoundsSize = parent.layer.animation(forKey: "bounds.size")! as! CABasicAnimation
        XCTAssertTrue(parentAnimationBoundsSize.isAdditive)
        XCTAssertEqual(parentAnimationBoundsSize.fromValue as! NSValue?, NSValue(cgSize: CGSize(width: -100, height: -100)))
        XCTAssertEqual(parentAnimationBoundsSize.toValue as! NSValue?, NSValue(cgSize: CGSize(width: 0, height: 0)))
        XCTAssertEqual(parentAnimationBoundsSize.timeOffset, 0)
        
        let childAnimationBoundsSize = child.layer.animation(forKey: "bounds.size")! as! CABasicAnimation
        XCTAssertTrue(childAnimationBoundsSize.isAdditive)
        XCTAssertEqual(childAnimationBoundsSize.fromValue as! NSValue?, NSValue(cgSize: CGSize(width: 50, height: 50)))
        XCTAssertEqual(childAnimationBoundsSize.toValue as! NSValue?, NSValue(cgSize: CGSize(width: 0, height: 0)))
        XCTAssertEqual(childAnimationBoundsSize.timeOffset, 0.3)
    }
}
