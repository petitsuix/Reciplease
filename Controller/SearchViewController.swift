//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Richardier on 25/05/2021.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
    // MARK: - Properties
    private var ingredientsArray: [String] = []
    private var recipes: [Recipe] = []
    
    @IBOutlet weak var searchTextField: UITextField! { didSet { searchTextField?.addDoneToolbar() } }
    @IBOutlet weak var addIngredientButton: UIButton!
    @IBOutlet weak var ingredientsListTextView: UITextView!
    @IBOutlet weak var searchActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchRecipesButton: UIButton!
    
    
    // MARK: - View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addIngredientButton.roundingButtonCorners(radius: 5)
        searchRecipesButton.roundingButtonCorners(radius: 15)
        searchActivityIndicator.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    // MARK: - Methods
    private func ingredientsListFormatted() -> String {
        return ingredientsArray.joined(separator: ",")
    }
    
    private func addIngredient(_ ingredient: String) {
        ingredientsListTextView.text.append("• \(ingredient)\n")
        ingredientsArray.append(ingredient)
    }
    
    private func cleanSearchBar() {
        searchTextField.text = ""
    }
    
    private func pushRecipesList() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let recipesListViewController = storyboard.instantiateViewController(withIdentifier: "List View Controller") as? ListViewController else { return } // Instantiation
        recipesListViewController.ingredients = ingredientsListFormatted()
        recipesListViewController.recipes = recipes
        recipesListViewController.dataMode = .api
        navigationController?.isNavigationBarHidden = false
        navigationController?.pushViewController(recipesListViewController, animated: true)
    }
    
    
    // MARK: - IBAction methods
    @IBAction func didPressAddButton(_ sender: Any) {
        if searchTextField.text == "" { alert("Missing ingredient", "Some characters are missing..."); return }
        guard let ingredient = searchTextField.text else { return } // TODO: détailler
        addIngredient(ingredient)
        searchTextField.doneButtonTapped()
        cleanSearchBar()
    }
    
    @IBAction func didPressClearListButton(_ sender: Any) {
        ingredientsArray.removeAll()
        ingredientsListTextView.text = ""
    }
    
    @IBAction func didPressSearchRecipesButton(_ sender: Any) {
        if ingredientsArray.isEmpty {
            return alert("Something's missing", "You must add at least one ingredient")
        }
        pushRecipesList()
    }
}
