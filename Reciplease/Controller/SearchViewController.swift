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
    
    @IBOutlet weak var searchBar: UITextField! { didSet { searchBar?.addDoneToolbar() } }
    @IBOutlet weak var addIngredientButton: UIButton!
    @IBOutlet weak var ingredientsListTextView: UITextView!
    @IBOutlet weak var clearListButton: UIButton!
    @IBOutlet weak var searchActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchRecipesButton: UIButton!
    
    // MARK: - View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - IBAction methods
    
    @IBAction func didPressAddButton(_ sender: Any) {
        guard let ingredient = searchBar.text, ingredient != "" else {
            print("Error searchBar: characters are missing, or searchBar.text is nil")
            alert("Something's missing", "Some characters are missing...")
            return
        }
        addIngredient(ingredient)
        searchBar.doneButtonTapped() // resigns first responder
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
        pushSearchResultsList()
    }
    
    // MARK: - Methods
    
    private func configureView() {
        searchActivityIndicator.isHidden = true
        
        addIngredientButton.adjustsImageSizeForAccessibilityContentSizeCategory = true
        addIngredientButton.roundingButtonCorners(radius: 5)
        
        clearListButton.adjustsImageSizeForAccessibilityContentSizeCategory = true
        clearListButton.roundingButtonCorners(radius: 5)
        
        searchRecipesButton.adjustsImageSizeForAccessibilityContentSizeCategory = true
        searchRecipesButton.roundingButtonCorners(radius: 15)
    }
    
    private func addIngredient(_ ingredient: String) {
        ingredientsListTextView.text.append("• \(ingredient.capitalizingFirstLetter())\n")
        ingredientsArray.append(ingredient)
    }
    
    private func cleanSearchBar() {
        searchBar.text = ""
    }
    
    // ⬇︎ Ensures user's ingredients list translates as a readable line of characters for a request
    private func ingredientsListFormatted() -> String {
        return ingredientsArray.joined(separator: ",")
    }
    
    private func pushSearchResultsList() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let listViewController = storyboard.instantiateViewController(withIdentifier: "List View Controller") as? ListViewController else { return } // Instantiating the given controller
        listViewController.ingredients = ingredientsListFormatted()
        listViewController.dataMode = .api
        navigationController?.isNavigationBarHidden = false
        navigationController?.pushViewController(listViewController, animated: true) // Pushing listViewController after changing .dataMode default value to .api
    }
}
