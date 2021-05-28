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
    var dataRecipe: InfoEdamamRequest?
    
    
    @IBOutlet weak var searchTextField: UITextField! { didSet { searchTextField?.addDoneToolbar() } }
    @IBOutlet weak var ingredientsListTextView: UITextView!
    @IBOutlet weak var searchActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchRecipesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchActivityIndicator.isHidden = true
        let notificationName = NSNotification.Name(rawValue: "ingredients updated")
        NotificationCenter.default.addObserver(self, selector: #selector(ingredientsListUpdated), name: notificationName, object: nil)
        
        let notificationErrorName = NSNotification.Name(rawValue: "alert missing ingredient")
        NotificationCenter.default.addObserver(self, selector: #selector(showAlert), name: notificationErrorName, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    @IBAction func addIngredientButton(_ sender: Any) {
        if searchTextField.text == "" { showAlert(); return }
        guard let ingredient = searchTextField.text else { return }
        operationLogic.addIngredient(ingredient)
        searchTextField.doneButtonTapped()
        operationLogic.cleanSearchBar()
    }
    
    @IBAction func searchRecipes(_ sender: Any) {
        searchRecipesButton.isHidden = true
        searchActivityIndicator.isHidden = false
        RecipeService.shared.searchRecipes(for: operationLogic.ingredientsListFormatted()) { result in
            switch result {
            case .success(let recipes):
                print(recipes)
                OperationLogic.recipes = recipes.recipes
                self.dataRecipe = recipes
                self.searchRecipesButton.isHidden = false
                self.searchActivityIndicator.isHidden = true
                self.performSegue(withIdentifier: "SearchToList", sender: nil)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dataController = segue.destination as? RecipesListViewController {
            dataController.dataRecipe = self.dataRecipe
        }
    }
    
}
