//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Richardier on 25/05/2021.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AF.request("https://api.edamam.com/search?app_id=86be18cd&app_key=ce95c1d699e31afdd6ff6a5b0e9e8906&q=chicken,tomato,potato,peach,ginger").response { response in
            debugPrint(response)
        }
    }
}
