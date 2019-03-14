//
//  AnimationsTimingViewController.swift
//  UIAnimationToolbox
//
//  Created on 2019/3/14.
//

import UIKit
import UIAnimationToolbox

enum AnimationsTimingConfiguration: String {
    case beginTime = "BeginTime"
    case duration = "Duration"
    case speed = "Speed"
    case timeOffset = "TimeOffset"
    case repeatingByCount = "Repeating by Count"
    case repeatingByDuration = "Repeating by Duration"
    case autoreverses = "Autoreverses"
    case fillMode = "FillMode"
    
    var pseudoCode: String {
        switch self {
        case .beginTime:
            return """
            UIView.animate(withDuration: animationDuration) {
                //...
                UIView.shiftAnimationsTiming(beginTime: yourBeginTime) {
                    //...
                }
            }
            """
        case .duration:
            return """
            UIView.animate(withDuration: animationDuration) {
                //...
                UIView.shiftAnimationsTiming(duration: yourDuration) {
                    //...
                }
            }
            """
        case .speed:
            return """
            UIView.animate(withDuration: animationDuration) {
                //...
                UIView.shiftAnimationsTiming(speed: yourSpeed) {
                    //...
                }
            }
            """
        case .timeOffset:
            return """
            UIView.animate(withDuration: animationDuration) {
                //...
                UIView.shiftAnimationsTiming(timeOffset: yourTimeOffset) {
                    //...
                }
            }
            """
        case .repeatingByCount:
            return """
            UIView.animate(withDuration: animationDuration) {
                //...
                UIView.shiftAnimationsTiming(repeating: byCount(yourCount)) {
                    //...
                }
            }
            """
        case .repeatingByDuration:
            return """
            UIView.animate(withDuration: animationDuration) {
                //...
                UIView.shiftAnimationsTiming(repeating: byDuration(yourDuration)) {
                    //...
                }
            }
            """
        case .autoreverses:
            return """
            UIView.animate(withDuration: animationDuration) {
                //...
                UIView.shiftAnimationsTiming(autoreverses: true) {
                    //...
                }
            }
            """
        case .fillMode:
            return """
            UIView.animate(withDuration: animationDuration) {
                //...
                UIView.shiftAnimationsTiming(fillMode: yourFillMode) {
                    //...
                }
            }
            """
        }
    }
}

class AnimationsTimingViewController: UITableViewController {
    var configuration: AnimationsTimingConfiguration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timmingContentLabel.text = configuration.rawValue
        animationView.dataSource = self
        animationView.delegate = self
        let view = AnimationsTimingControl.make(
            configuration: configuration!,
            controller: self
        )
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        
        settingsContolCellContentView.addSubview(view)
        
        let constraints = [
            NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: settingsContolCellContentView, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: settingsContolCellContentView, attribute: .trailing, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: settingsContolCellContentView, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: settingsContolCellContentView, attribute: .bottom, multiplier: 1.0, constant: 0),
        ]
        
        settingsContolCellContentView.addConstraints(constraints)
        
        codeTextView.textContainer.lineBreakMode = .byCharWrapping
        codeTextView.text = configuration.pseudoCode
    }
    
    @IBOutlet weak var timmingContentLabel: UILabel!
    
    @IBOutlet weak var settingsContolCellContentView: UIView!
    
    @IBOutlet weak var animationView: AnimationsTimingAnimationView!
    
    @IBAction func playAnimationButtonDidTap(_ sender: UIBarButtonItem) {
        sender.isEnabled = false
        animationView.play()
    }
    
    @IBOutlet weak var playAnimationButton: UIBarButtonItem!
    
    @IBOutlet weak var codeTextView: UITextView!
    
    var animationDuration: TimeInterval = 1.0
    var beginTime: TimeInterval = 0.5
    var duration: TimeInterval = 0.5
    var speed: CGFloat = 0.5
    var timeOffset: TimeInterval = 0.2
    var repeating: CGFloat = 2
    var autoreverses: Bool = true
    var fillMode: UIAnimationTimingFillMode = .backwards
    
    func indexForFillMode(_ fillMode: UIAnimationTimingFillMode) -> Int {
        switch fillMode {
        case .removed:      return 0
        case .backwards:    return 1
        case .forwards:     return 2
        case .both:         return 3
        }
    }
    
    func fillModeForIndex(_ index: Int) -> UIAnimationTimingFillMode {
        switch index {
        case 0: return  .removed
        case 1: return  .backwards
        case 2: return  .forwards
        case 3: return  .both
        default:    fatalError()
        }
    }
}

extension AnimationsTimingViewController: AnimationsTimingAnimationViewDelegate {
    func animationsTimingAnimationViewDidEndAnimation(_ sender: AnimationsTimingAnimationView) {
        playAnimationButton.isEnabled = true
    }
}

extension AnimationsTimingViewController: AnimationsTimingAnimationViewDataSource {
    func animationViewConfiguration(_ sender: AnimationsTimingAnimationView) -> AnimationsTimingConfiguration {
        return configuration
    }
    
    func animationViewAnimationDuration(_ sender: AnimationsTimingAnimationView) -> TimeInterval {
        return animationDuration
    }
    
    func animationViewBeginTime(_ sender: AnimationsTimingAnimationView) -> TimeInterval {
        return beginTime
    }
    
    func animationViewDuration(_ sender: AnimationsTimingAnimationView) -> TimeInterval {
        return duration
    }
    
    func animationViewSpeed(_ sender: AnimationsTimingAnimationView) -> CGFloat {
        return speed
    }
    
    func animationViewTimeOffset(_ sender: AnimationsTimingAnimationView) -> TimeInterval {
        return timeOffset
    }
    
    func animationViewRepeating(_ sender: AnimationsTimingAnimationView) -> CGFloat {
        return repeating
    }
    
    func animationViewAutoreverses(_ sender: AnimationsTimingAnimationView) -> Bool {
        return autoreverses
    }
    
    func animationViewFillMode(_ sender: AnimationsTimingAnimationView) -> UIAnimationTimingFillMode {
        return fillMode
    }
}

extension AnimationsTimingViewController: AnimationsTimingControlDelegate { }

extension AnimationsTimingViewController: AnimationsTimingControlSegmentsDelegate {
    func animationsTimingControlSegments(_ sender: AnimationsTimingControlSegments, didSelectAt index: Int) {
        switch configuration! {
        case .fillMode: fillMode = fillModeForIndex(index)
        default: break
        }
    }
}

extension AnimationsTimingViewController: AnimationsTimingControlSwitchDelegate {
    func animationsTimingControlSwitch(_ sender: AnimationsTimingControlSwitch, didToggle value: Bool) {
        switch configuration! {
        case .autoreverses:
            autoreverses = value
        default: break
        }
    }
}

extension AnimationsTimingViewController: AnimationsTimingControlStepperDelegate {
    func animationsTimingControlStepper(_ sender: AnimationsTimingControlStepper, didChangeValue value: Double) {
        switch configuration! {
        case .beginTime:            beginTime = value
        case .duration:             duration = value
        case .speed:                speed = CGFloat(value)
        case .timeOffset:           timeOffset = value
        case .repeatingByCount:     repeating = CGFloat(value)
        case .repeatingByDuration:  repeating = CGFloat(value)
        default: break
        }
    }
}
