//
//  AnimationsTimingControl.swift
//  UIAnimationToolboxCategory-iOS
//
//  Created by WeZZard on 2019/3/14.
//

import UIKit

protocol AnimationsTimingControlDelegate: NSObjectProtocol {
    
}

class AnimationsTimingControl: UIView {
    weak var delegate: AnimationsTimingControlDelegate?
    
    static func make(
        configuration: AnimationsTimingConfiguration,
        controller: AnimationsTimingViewController
        ) -> AnimationsTimingControl
    {
        switch configuration {
        case .beginTime:
            let view: AnimationsTimingControlStepper = .makeFromNib()
            view.stepper.minimumValue = 0
            view.stepper.maximumValue = controller.animationDuration
            view.stepper.stepValue = 0.1
            view.stepper.value = controller.beginTime
            view.titleLabel.text = "\(controller.beginTime)"
            return view
        case .duration:
            let view: AnimationsTimingControlStepper = .makeFromNib()
            view.stepper.minimumValue = 0
            view.stepper.maximumValue = controller.animationDuration
            view.stepper.stepValue = 0.1
            view.stepper.value = controller.duration
            view.titleLabel.text = "\(controller.duration)"
            return view
        case .speed:
            let view: AnimationsTimingControlStepper = .makeFromNib()
            view.stepper.minimumValue = 0
            view.stepper.maximumValue = 4
            view.stepper.stepValue = 0.5
            view.stepper.value = Double(controller.speed)
            view.titleLabel.text = "\(controller.speed)"
            return view
        case .timeOffset:
            let view: AnimationsTimingControlStepper = .makeFromNib()
            view.stepper.minimumValue = 0
            view.stepper.maximumValue = controller.animationDuration
            view.stepper.stepValue = 0.1
            view.stepper.value = controller.timeOffset
            view.titleLabel.text = configuration.rawValue
            view.titleLabel.text = "\(controller.timeOffset)"
            return view
        case .repeatingByCount:
            let view: AnimationsTimingControlStepper = .makeFromNib()
            view.stepper.minimumValue = 0
            view.stepper.maximumValue = 4
            view.stepper.stepValue = 0.5
            view.stepper.value = Double(controller.repeating)
            view.titleLabel.text = configuration.rawValue
            view.titleLabel.text = "\(controller.repeating)"
            return view
        case .repeatingByDuration:
            let view: AnimationsTimingControlStepper = .makeFromNib()
            view.stepper.minimumValue = 0
            view.stepper.maximumValue = 4
            view.stepper.stepValue = 0.5
            view.stepper.value = Double(controller.repeating)
            view.titleLabel.text = "\(controller.repeating)"
            return view
        case .autoreverses:
            let view: AnimationsTimingControlSwitch = .makeFromNib()
            view.switch.isOn = controller.autoreverses
            view.titleLabel.text = controller.autoreverses ? "Enabled" : "Disabled"
            return view
        case .fillMode:
            let view: AnimationsTimingControlSegments = .makeFromNib()
            view.segmentedControl.removeAllSegments()
            view.segmentedControl.insertSegment(withTitle: "Removed", at: 0, animated: false)
            view.segmentedControl.insertSegment(withTitle: "Backwards", at: 1, animated: false)
            view.segmentedControl.insertSegment(withTitle: "Forwards", at: 2, animated: false)
            view.segmentedControl.insertSegment(withTitle: "Both", at: 3, animated: false)
            view.segmentedControl.selectedSegmentIndex = controller.indexForFillMode(controller.fillMode)
            return view
        }
    }
}

protocol AnimationsTimingControlSegmentsDelegate:
    AnimationsTimingControlDelegate
{
    func animationsTimingControlSegments(_ sender: AnimationsTimingControlSegments, didSelectAt index: Int)
}

class AnimationsTimingControlSegments: AnimationsTimingControl {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        guard let delegate = delegate as? AnimationsTimingControlSegmentsDelegate else { return }
        delegate.animationsTimingControlSegments(self, didSelectAt: sender.selectedSegmentIndex)
    }
}

protocol AnimationsTimingControlSwitchDelegate:
    AnimationsTimingControlDelegate
{
    func animationsTimingControlSwitch(_ sender: AnimationsTimingControlSwitch, didToggle value: Bool)
}

class AnimationsTimingControlSwitch: AnimationsTimingControl {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        guard let delegate = delegate as? AnimationsTimingControlSwitchDelegate else { return }
        delegate.animationsTimingControlSwitch(self, didToggle: sender.isOn)
        titleLabel.text = sender.isOn ? "Enabled" : "Disabled"
    }
}

protocol AnimationsTimingControlStepperDelegate:
    AnimationsTimingControlDelegate
{
    func animationsTimingControlStepper(_ sender: AnimationsTimingControlStepper, didChangeValue value: Double)
}

class AnimationsTimingControlStepper: AnimationsTimingControl {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        guard let delegate = delegate as? AnimationsTimingControlStepperDelegate else { return }
        delegate.animationsTimingControlStepper(self, didChangeValue: sender.value)
        titleLabel.text = String(format: "%.1f", sender.value)
    }
}
