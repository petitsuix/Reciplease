//
//  CornerRadius.swift
//  Reciplease
//
//  Created by Richardier on 04/06/2021.
//

import UIKit

extension UIButton {
    func roundingButtonCorners(radius: Int) {
    self.layer.masksToBounds = true
        self.layer.cornerRadius = CGFloat(radius)
    }
}

extension UIView {
    func roundingViewCorners(radius: Int) {
    self.layer.masksToBounds = true
        self.layer.cornerRadius = CGFloat(radius)
    }
}
