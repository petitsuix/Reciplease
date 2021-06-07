//
//  CornerRadius.swift
//  Reciplease
//
//  Created by Richardier on 04/06/2021.
//

import UIKit

extension UIButton {
    func roundingButtonCorners() {
    self.layer.masksToBounds = true
    self.layer.cornerRadius = 5
    }
}
