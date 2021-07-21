//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Richardier on 25/05/2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Properties
    private var ingredientsArray: [String] = []
    private var recipes: [Recipe] = []
    
    @IBOutlet weak var searchBar: UITextField! { didSet { searchBar?.addDoneToolbar() } }
    @IBOutlet weak var addIngredientButton: UIButton!
    @IBOutlet weak var ingredientsListTextView: UITextView!
    @IBOutlet weak var clearListButton: UIButton!
    @IBOutlet weak var searchActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchRecipesButton: UIButton!
    
    // MARK: - View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addIngredientButton.roundingButtonCorners(radius: 5)
        clearListButton.roundingButtonCorners(radius: 5)
        searchRecipesButton.roundingButtonCorners(radius: 15)
        searchActivityIndicator.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    // MARK: - Methods
    private func ingredientsListFormatted() -> String {
        return ingredientsArray.joined(separator: ",")
    }
    
    private func addIngredient(_ ingredient: String) {
        ingredientsListTextView.text.append("• \(ingredient.capitalizingFirstLetter())\n")
        ingredientsArray.append(ingredient)
    }
    
    private func cleanSearchBar() {
        searchBar.text = ""
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
        //        if searchBar.text == "" { alert("Missing ingredient", "Some characters are missing..."); return }
        guard let ingredient = searchBar.text, ingredient != "" else {
            print("Error searchBar: characters are missing, or searchBar.text is nil")
            alert("Something's missing", "Some characters are missing...")
            return
        }
        addIngredient(ingredient)
        searchBar.doneButtonTapped()
        cleanSearchBar()
    }
    
    @IBAction func didPressClearListButton(_ sender: Any) {
        ingredientsArray.removeAll()
        ingredientsListTextView.text = ""
    }
    
    @IBAction func didPressSearchRecipesButton(_ sender: Any) {
        if ingredientsArray.isEmpty {
            return alert("Missing ingredient", "You should have at least one ingredient in your list")
        }
        pushRecipesList()
    }
}
