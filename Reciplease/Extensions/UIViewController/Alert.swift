//
//  ShowAlert.swift
//  Reciplease
//
//  Created by Richardier on 27/05/2021.
//

import UIKit

extension UIViewController {
    
    func alert(_ title: String, _ message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}


