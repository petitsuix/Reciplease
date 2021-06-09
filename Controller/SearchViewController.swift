//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Richardier on 25/05/2021.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
 //   var operationLogic = OperationLogic()
    
    var ingredientsArray: [String] = []
    var recipes: [Recipe] = []
    
    @IBOutlet weak var searchTextField: UITextField! { didSet { searchTextField?.addDoneToolbar() } }
    @IBOutlet weak var addIngredientButton: UIButton!
    @IBOutlet weak var ingredientsListTextView: UITextView!
    @IBOutlet weak var searchActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchRecipesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addIngredientButton.roundingButtonCorners(radius: 5)
        searchRecipesButton.roundingButtonCorners(radius: 15)
        searchActivityIndicator.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    private func ingredientsListFormatted() -> String {
        return ingredientsArray.joined(separator: ",")
    }
    
    func addIngredient(_ ingredient: String) {
        ingredientsListTextView.text.append("• \(ingredient)\n")
        ingredientsArray.append(ingredient)
    }
    
    func cleanSearchBar() {
        searchTextField.text = ""
    }
    
    func cleanIngredientsList() {
        // ingredientsArray.removeAll()
    }
    
    func fetchRecipes() {
        searchRecipesButton.isHidden = true
        searchActivityIndicator.isHidden = false
        RecipeService.shared.fetchData(for: ingredientsListFormatted()) { result in
            self.searchRecipesButton.isHidden = false
            self.searchActivityIndicator.isHidden = true
            switch result {
            case .success(let infoEdamamRequest):
                print(infoEdamamRequest)
                self.recipes = infoEdamamRequest.recipes
                self.pushRecipesList()

//                self.performSegue(withIdentifier: "SearchToList", sender: nil) // créer methode pushRecipesList dans laquelle on aura une instantiation des storyboards
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func pushRecipesList() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let recipesListViewController = storyboard.instantiateViewController(withIdentifier: "List View Controller") as? ListViewController else { return } // Instantiation
        
        recipesListViewController.recipes = recipes
        recipesListViewController.dataMode = .api
        navigationController?.isNavigationBarHidden = false
        navigationController?.pushViewController(recipesListViewController, animated: true)
    }
    
    @IBAction func didPressAddButton(_ sender: Any) {
        if searchTextField.text == "" { alert("Missing ingredient", "It seems you forgot to add one"); return }
        guard let ingredient = searchTextField.text else { return } // TODO: détailler
        addIngredient(ingredient)
        searchTextField.doneButtonTapped()
        cleanSearchBar()
    }
    
    @IBAction func didPressSearchRecipesButton(_ sender: Any) {
        fetchRecipes()
        //pushRecipesList()
        /// methode pushRecipeList() qui instancie controller
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let recipeListViewController = segue.destination as? RecipesListViewController {
//            recipeListViewController.recipes = recipes
//            recipeListViewController.dataMode = .api
//        }
//    }
}
