//
//  UIView+Additions.swift
//  UIAnimationToolbox
//
//  Created on 2019/3/14.
//

import UIKit


extension UIView {
    static func makeFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: self, options: nil)![0] as! T
    }
}
