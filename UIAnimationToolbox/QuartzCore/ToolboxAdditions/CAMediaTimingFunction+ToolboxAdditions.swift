//
//  CAMediaTimingFunction+ToolboxAdditions.swift
//  UIAnimationToolbox
//
//  Created by WeZZard on 11/20/15.
//
//

import QuartzCore

public func == (lhs: CAMediaTimingFunction, rhs: CAMediaTimingFunction) -> Bool {
    return lhs.controlPoints == rhs.controlPoints
}

// MARK: Getting Control Points
extension CAMediaTimingFunction {
    public subscript(index: UInt) -> CGPoint {
        switch index {
        case 0...3:
            let controlPoint = UnsafeMutablePointer<Float>.allocate(capacity: 2)
            getControlPoint(at: Int(index), values: controlPoint)
            let x: Float = controlPoint[0]
            let y: Float = controlPoint[1]
            controlPoint.deallocate()
            return CGPoint(x: CGFloat(x), y: CGFloat(y))
        default:
            fatalError("Index\(index) is beyond the boundary, shall be 0...3")
        }
    }
    
    public var controlPoints: [CGPoint] {
        return (0...3).map({self[$0]})
    }
}

// MARK: Evaluate Y
extension CAMediaTimingFunction {
    private typealias _CGFloat4 = (CGFloat, CGFloat, CGFloat, CGFloat)
    
    @objc(uiat_evaluateYForX:)
    public func evaluateY(forX x: CGFloat) -> CGFloat {
        precondition(
            MemoryLayout<_CGFloat4>.size == 4 * MemoryLayout<CGFloat>.size
        )
        
        let cp1 = self[1]
        let cp2 = self[2]
        
        let c1x = cp1.x
        let c1y = cp1.y
        let c2x = cp2.x
        let c2y = cp2.y
        
        var coefficientsX: _CGFloat4 = (
            _c0x, // t^0
            -3.0*_c0x + 3.0*c1x, // t^1
            3.0*_c0x - 6.0*c1x + 3.0*c2x,  // t^2
            -_c0x + 3.0*c1x - 3.0*c2x + _c3x // t^3
        )
        
        var coefficientsY: _CGFloat4 = (
            _c0y, // t^0
            -3.0*_c0y + 3.0*c1y, // t^1
            3.0*_c0y - 6.0*c1y + 3.0*c2y,  // t^2
            -_c0y + 3.0*c1y - 3.0*c2y + _c3y // t^3
        )
        
        let coefficientsXPtr = withUnsafePointer(to: &coefficientsX, {$0})
            .withMemoryRebound(to: CGFloat.self, capacity: 4, {$0})
        let coefficientsYPtr = withUnsafePointer(to: &coefficientsY, {$0})
            .withMemoryRebound(to: CGFloat.self, capacity: 4, {$0})
        
        let t = _calculateParameter(forX: x, coefficients: coefficientsXPtr)
        let y = _evaluate(at: t, coefficients: coefficientsYPtr)
        
        return y
    }
    
    @inline(__always)
    private func _evaluate(
        at t: CGFloat , coefficients: UnsafePointer<CGFloat>
        ) -> CGFloat
    {
        return coefficients[0]
            + (t * coefficients[1])
            + (t * t * coefficients[2])
            + (t * t * t * coefficients[3])
    }
    
    @inline(__always)
    private func _evaluateDerivation(
        at t: CGFloat, coefficients: UnsafePointer<CGFloat>
        ) -> CGFloat
    {
        return coefficients[1]
            + (2 * t * coefficients[2])
            + (3 * t * t * coefficients[3])
    }
    
    @inline(__always)
    private func _calculateParameterViaNewtonRaphson(
        forX x: CGFloat, coefficients: UnsafePointer<CGFloat>
        ) -> CGFloat
    {
        // see http://en.wikipedia.org/wiki/Newton's_method
        
        // start with X being the correct value
        var t: CGFloat = x
        
        // iterate several times
        for _ in 0..<10 {
            
            let x2 = _evaluate(at: t, coefficients: coefficients) - x
            let d = _evaluateDerivation(at: t, coefficients: coefficients)
            
            let dt = x2/d
            
            t = t - dt
        }
        
        return t
    }
    
    @inline(__always)
    private func _calculateParameter(
        forX x: CGFloat, coefficients: UnsafePointer<CGFloat>
        ) -> CGFloat
    {
        // for the time being, we'll guess Newton-Raphson always
        // returns the correct value.
        
        // if we find it doesn't find the solution often enough,
        // we can add additional calculation methods.
        
        let t = _calculateParameterViaNewtonRaphson(
            forX: x, coefficients: coefficients
        )
        
        return t
    }
}

private let _c0x: CGFloat = 0.0
private let _c0y: CGFloat = 0.0
private let _c3x: CGFloat = 1.0
private let _c3y: CGFloat = 1.0
