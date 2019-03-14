//
//  AnimationInterpolatorViewController.swift
//  UIAnimationToolbox
//
//  Created on 2019/3/14.
//

import UIKit

class AnimationInterpolatorViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.blockAnimationProgressLabel.text = "0"
        self.springAnimationProgressLabel.text = "0"
        self.pseudoCodeTextView.textContainer.lineBreakMode = .byCharWrapping
        self.pseudoCodeTextView.text = """
        UIView.animate(withDuration: duration) {
            UIView.addAnimationInterpolator {
                (progress) in
                self.label.text = ...
            }
        }
        """
    }
    
    @IBOutlet weak var playButton: UIBarButtonItem!
    
    @IBAction func playButtonDidTap(_ sender: UIBarButtonItem) {
        sender.isEnabled = false
        UIView.animate(withDuration: 2.0, animations: {
            self.blockAnimationTralingConstraint.priority = .defaultHigh
            self.blockAnimationsContainerView.setNeedsUpdateConstraints()
            self.blockAnimationsContainerView.layoutIfNeeded()
            UIView.addAnimationInterpolator({ (progress) in
                self.blockAnimationProgressLabel.text = String(format: "%.2f", progress)
            })
        }) { _ in
            UIView.animate(withDuration: 1.0, animations: {
                self.blockAnimationTralingConstraint.priority = .defaultLow
                self.blockAnimationsContainerView.setNeedsUpdateConstraints()
                self.blockAnimationsContainerView.layoutIfNeeded()
                UIView.addAnimationInterpolator({ (progress) in
                    self.blockAnimationProgressLabel.text = String(format: "%.2f", progress)
                })
            }, completion: { _ in
                self.blockAnimationProgressLabel.text = "0"
            })
        }
        
        UIView.animate(
            withDuration: 2.0,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.2,
            options: [],
            animations: {
                self.springAnimationTralingConstraint.priority = .defaultHigh
                self.springAnimationsContainerView.setNeedsUpdateConstraints()
                self.springAnimationsContainerView.layoutIfNeeded()
                UIView.addAnimationInterpolator({ (progress) in
                    self.springAnimationProgressLabel.text = String(format: "%.2f", progress)
                })
        }) { _ in
            sender.isEnabled = true
            UIView.animate(withDuration: 1.0, animations: {
                self.springAnimationTralingConstraint.priority = .defaultLow
                self.springAnimationsContainerView.setNeedsUpdateConstraints()
                self.springAnimationsContainerView.layoutIfNeeded()
                UIView.addAnimationInterpolator({ (progress) in
                    self.springAnimationProgressLabel.text = String(format: "%.2f", progress)
                })
            }, completion: { _ in
                self.springAnimationProgressLabel.text = "0"
            })
        }
    }
    
    @IBOutlet weak var blockAnimationTralingConstraint: NSLayoutConstraint!
    @IBOutlet weak var blockAnimationsContainerView: UIView!
    @IBOutlet weak var blockAnimationProgressLabel: UILabel!
    
    @IBOutlet weak var springAnimationTralingConstraint: NSLayoutConstraint!
    @IBOutlet weak var springAnimationsContainerView: UIView!
    @IBOutlet weak var springAnimationProgressLabel: UILabel!
    
    @IBOutlet weak var pseudoCodeTextView: UITextView!
}
