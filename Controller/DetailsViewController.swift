//
//  DetailsViewController.swift
//  Reciplease
//
//  Created by Richardier on 07/06/2021.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var recipePicture: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var ingredients: UITextField!
    @IBOutlet weak var getDirectionsButton: UIButton!
    
    var recipes: [Recipe] = []
    var recipe: Recipe?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // print(recipe)
        recipeName.text = recipe?.name
        ingredients.text = recipe?.ingredients.joined(separator: ", ")
        let navBarRightItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(addToFavorites))
        self.navigationItem.rightBarButtonItem = navBarRightItem
        // Do any additional setup after loading the view.
    }
    
    @objc func addToFavorites() {
        if self.navigationItem.rightBarButtonItem?.image == UIImage(systemName: "heart.fill") {
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
        } else {
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
