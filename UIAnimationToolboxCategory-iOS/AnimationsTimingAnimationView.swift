//
//  AnimationsTimingAnimationView.swift
//  UIAnimationToolbox
//
//  Created on 2019/3/14.
//

import UIKit
import UIAnimationToolbox

protocol AnimationsTimingAnimationViewDataSource: NSObjectProtocol {
    func animationViewConfiguration(_ sender: AnimationsTimingAnimationView) -> AnimationsTimingConfiguration
    func animationViewAnimationDuration(_ sender: AnimationsTimingAnimationView) -> TimeInterval
    func animationViewBeginTime(_ sender: AnimationsTimingAnimationView) -> TimeInterval
    func animationViewDuration(_ sender: AnimationsTimingAnimationView) -> TimeInterval
    func animationViewSpeed(_ sender: AnimationsTimingAnimationView) -> CGFloat
    func animationViewTimeOffset(_ sender: AnimationsTimingAnimationView) -> TimeInterval
    func animationViewRepeating(_ sender: AnimationsTimingAnimationView) -> CGFloat
    func animationViewAutoreverses(_ sender: AnimationsTimingAnimationView) -> Bool
    func animationViewFillMode(_ sender: AnimationsTimingAnimationView) -> UIAnimationTimingFillMode
}

protocol AnimationsTimingAnimationViewDelegate: NSObjectProtocol {
    func animationsTimingAnimationViewDidEndAnimation(_ sender: AnimationsTimingAnimationView)
}

class AnimationsTimingAnimationView: UIView {
    weak var dataSource: AnimationsTimingAnimationViewDataSource!
    weak var delegate: AnimationsTimingAnimationViewDelegate!
    
    @IBOutlet weak var normalTimingIndicator: UIView!
    
    @IBOutlet weak var normalTimingTralingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var shiftedTimingIndicator: ShiftedTimingIndicator!
    
    @IBOutlet weak var shiftedTimingLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var shiftedTimingTralingConstraint: NSLayoutConstraint!
    
    func play() {
        _animate(
            {
                self.normalTimingTralingConstraint.priority = .defaultHigh
                self.setNeedsUpdateConstraints()
                self.layoutIfNeeded()
            },
            {
                self.shiftedTimingTralingConstraint.priority = .defaultHigh
                self.shiftedTimingLeadingConstraint.priority = .defaultLow
                self.setNeedsUpdateConstraints()
                self.layoutIfNeeded()
            },
            { _ in
                UIView.animate(withDuration: 1.0, animations: {
                    self.normalTimingTralingConstraint.priority = .defaultLow
                    self.shiftedTimingTralingConstraint.priority = .defaultLow
                    self.shiftedTimingLeadingConstraint.priority = .defaultHigh
                    self.setNeedsUpdateConstraints()
                    self.layoutIfNeeded()
                }, completion: { _ in
                    self.delegate?.animationsTimingAnimationViewDidEndAnimation(self)
                })
            }
        )
    }
    
    func _animate(
        _ animations: @escaping () -> Void,
        _ timingShiftedAnimations: @escaping () -> Void,
        _ completion: @escaping (Bool) -> Void
        )
    {
        guard let dataSource = dataSource else { return }
        
        UIView.animate(withDuration: dataSource.animationViewAnimationDuration(self), animations: {
            animations()
            switch dataSource.animationViewConfiguration(self) {
            case .beginTime:
                UIView.shiftAnimationsTiming(
                    beginTime: dataSource.animationViewBeginTime(self),
                    animations: timingShiftedAnimations
                )
            case .duration:
                UIView.shiftAnimationsTiming(
                    duration: dataSource.animationViewDuration(self),
                    animations: timingShiftedAnimations
                )
            case .speed:
                UIView.shiftAnimationsTiming(
                    speed: dataSource.animationViewSpeed(self),
                    animations: timingShiftedAnimations
                )
            case .timeOffset:
                UIView.shiftAnimationsTiming(
                    timeOffset: dataSource.animationViewTimeOffset(self),
                    animations: timingShiftedAnimations
                )
            case .repeatingByCount:
                UIView.shiftAnimationsTiming(
                    repeating: .byCount(dataSource.animationViewRepeating(self)),
                    animations: timingShiftedAnimations
                )
            case .repeatingByDuration:
                UIView.shiftAnimationsTiming(
                    repeating: .byDuration(TimeInterval(dataSource.animationViewRepeating(self))),
                    animations: timingShiftedAnimations
                )
            case .autoreverses:
                UIView.shiftAnimationsTiming(
                    autoreverses: dataSource.animationViewAutoreverses(self),
                    animations: timingShiftedAnimations
                )
            case .fillMode:
                UIView.shiftAnimationsTiming(
                    fillMode: dataSource.animationViewFillMode(self),
                    animations: timingShiftedAnimations
                )
            }
        }, completion: completion)
    }
}

class ShiftedTimingIndicator: UIView {
    override func prepareForInterfaceBuilder() {
        layer.cornerRadius = 15
    }
    
    override func awakeFromNib() {
        layer.cornerRadius = 15
    }
}
