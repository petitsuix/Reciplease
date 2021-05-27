//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Richardier on 25/05/2021.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
    var operationLogic = OperationLogic()
    
    @IBOutlet weak var searchTextField: UITextField! { didSet { searchTextField?.addDoneToolbar() } }
    @IBOutlet weak var ingredientsListTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationName = NSNotification.Name(rawValue: "ingredients updated")
        NotificationCenter.default.addObserver(self, selector: #selector(ingredientsListUpdated), name: notificationName, object: nil)
        
        let notificationErrorName = NSNotification.Name(rawValue: "alert missing ingredient")
        NotificationCenter.default.addObserver(self, selector: #selector(showAlert), name: notificationErrorName, object: nil)
    }
    @IBAction func addIngredientButton(_ sender: Any) {
        operationLogic.addIngredient(searchTextField.text!)
        searchTextField.doneButtonTapped()
        operationLogic.cleanSearchBar()
    }
    
    @IBAction func searchRecipes(_ sender: Any) {
        RecipeService().searchRecipes(for: operationLogic.ingredientsListFormatted()) { result in
            switch result {
            case .success(let recipes):
                print(recipes)
            case .failure(let error):
                print(error)
            }
        }
    }
    @objc func ingredientsListUpdated() {
        searchTextField.text = operationLogic.searchIngredientsTextField
        ingredientsListTextView.text = operationLogic.ingredientsListTextView
    }
    
    @objc func showAlert() {
        alert("Missing ingredient", "It seems you forgot to add one")
    }
    
}
