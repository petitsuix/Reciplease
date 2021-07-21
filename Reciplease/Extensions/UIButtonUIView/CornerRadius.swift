//
//  CornerRadius.swift
//  Reciplease
//
//  Created by Richardier on 04/06/2021.
//

import UIKit

// ⬇︎ Rounds the corresponding item's corners, based on a given radius
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
