//
//  LoadImage.swift
//  Reciplease
//
//  Created by Richardier on 08/06/2021.
//

import UIKit

extension UIImageView {
    
    // ⬇︎ Loads the corresponding photo
    func loadRecipePhoto(_ url: String) {
        
        let urlString = url
        print("\(urlString)")
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

