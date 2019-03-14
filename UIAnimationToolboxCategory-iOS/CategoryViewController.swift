//
//  CategoryViewController.swift
//  UIAnimationToolboxCategory-iOS
//
//  Created by WeZZard on 2019/3/14.
//

import UIKit

class CategoryViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showBeginTimeExample":
            let destinationVC = segue.destination as! AnimationsTimingViewController
            destinationVC.configuration = .beginTime
        case "showDurationExample":
            let destinationVC = segue.destination as! AnimationsTimingViewController
            destinationVC.configuration = .duration
        case "showSpeedExample":
            let destinationVC = segue.destination as! AnimationsTimingViewController
            destinationVC.configuration = .speed
        case "showTimeOffsetExample":
            let destinationVC = segue.destination as! AnimationsTimingViewController
            destinationVC.configuration = .timeOffset
        case "showRepeatingByCountExample":
            let destinationVC = segue.destination as! AnimationsTimingViewController
            destinationVC.configuration = .repeatingByCount
        case "showRepeatingByDurationExample":
            let destinationVC = segue.destination as! AnimationsTimingViewController
            destinationVC.configuration = .repeatingByDuration
        case "showAutoreversesExample":
            let destinationVC = segue.destination as! AnimationsTimingViewController
            destinationVC.configuration = .autoreverses
        case "showFillModeExample":
            let destinationVC = segue.destination as! AnimationsTimingViewController
            destinationVC.configuration = .fillMode
        default:
            break
        }
        super.prepare(for: segue, sender: sender)
    }
}
