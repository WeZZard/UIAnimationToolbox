//
//  CustomPropertiesViewController.swift
//  UIAnimationToolbox
//
//  Created on 2019/3/14.
//

import UIKit
import UIAnimationToolbox

class CustomPropertiesViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var clockView: ClockView!
}


extension CustomPropertiesViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UIView.animate(withDuration: 5.0, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
            switch component {
            case 0:     self.clockView.hour = CGFloat(row)
            case 1:     self.clockView.minute = CGFloat(row)
            default:    break
            }
        })
    }
}


extension CustomPropertiesViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return 24
        case 1: return 60
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0: return "\(row)"
        case 1: return "\(row)"
        default: return nil
        }
    }
}


// MARK: - ClockView
class ClockView: UIView {
    var hour: CGFloat {
        get { return _layer.hour }
        set { _layer.hour = newValue }
    }
    
    var minute: CGFloat {
        get { return _layer.minute }
        set { _layer.minute = newValue }
    }
    
    override class var layerClass: AnyClass {
        return ClockLayer.self
    }
    
    var _layer: ClockLayer { return layer as! ClockLayer }
    
    init(hour: CGFloat, minute: CGFloat, second: Float) {
        super.init(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        self.hour = hour
        self.minute = minute
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        hour = 0
        minute = 0
    }
    
    override func action(for layer: CALayer, forKey event: String) -> CAAction? {
        switch event {
        case "hour", "minute":
            return UIAnimationActionInferred(layer: layer, event: event)
        default:
            return super.action(for: layer, forKey: event)
        }
    }
    
    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()!
        UIGraphicsPushContext(ctx)
        
        UIColor.black.setFill()
        UIColor.clear.setStroke()
        
        let presentationLayer = _layer.presentation() ?? _layer
        
        let translate = CGAffineTransform(translationX: 150, y: 150)
        
        // draw hour
        let hourPath = UIBezierPath(rect: CGRect(x: -1, y: -9, width: 4, height: 70))
        let hourRotation = CGAffineTransform(rotationAngle: presentationLayer.hour / 12.0 * 2.0 * .pi - .pi)
        let hourTransform = hourRotation.concatenating(translate)
        hourPath.apply(hourTransform)
        hourPath.fill()
        
        // draw minute
        let minutePath = UIBezierPath(rect: CGRect(x: 0, y: -4, width: 2, height: 90))
        let minuteRotation = CGAffineTransform(rotationAngle: presentationLayer.minute / 60.0 * 2.0 * .pi - .pi)
        let minuteTransform = minuteRotation.concatenating(translate)
        minutePath.apply(minuteTransform)
        minutePath.fill()
        
        UIGraphicsPopContext()
    }
}

// MARK: - ClockLayer
class ClockLayer: CALayer {
    @NSManaged
    var hour: CGFloat
    
    @NSManaged
    var minute: CGFloat
    
    override class func needsDisplay(forKey key: String) -> Bool {
        switch key {
        case "hour", "minute":  return true
        default:                return super.needsDisplay(forKey: key)
        }
    }
}
