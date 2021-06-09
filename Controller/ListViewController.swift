//
//  SearchResultsViewController.swift
//  Reciplease
//
//  Created by Richardier on 27/05/2021.
//

import UIKit
import Alamofire

enum DataMode {
    case api
    case coreData
    var title: String {
        switch self {
        case .api:
            return "Result"
        case .coreData:
            return "Favorites"
        }
    }
}

class ListViewController: UIViewController, UINavigationBarDelegate {
    
    var recipes: [Recipe] = []
    var dataMode: DataMode = .api
    
    @IBOutlet weak var resultsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = dataMode.title
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
        //if dataMode = coreData, lit la BDD, recipes = coreDataservice.loadRecipes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resultsTableView.reloadData()
    }
    
    @objc func dismissListViewController(){
        dismiss(animated: true, completion: nil)
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    // faire les cellCustom dans le code, faire recipeCell
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRecipe = recipes[indexPath.row]
        displayRecipeDetailFor(selectedRecipe)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell") as? RecipeCell else {
            assertionFailure("Dequeue TableViewCell is of wrong type")
            return UITableViewCell()
        }
        cell.recipe = recipes[indexPath.row]
        return cell
    }
    
    private func displayRecipeDetailFor(_ recipe: Recipe) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
         guard let detailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsVC") as? DetailsViewController else { return }
        detailsViewController.recipe = recipe
        
//       detailsViewController.recipeName.text = recipes[0].name
      //  detailsViewController.recipes = recipes
        navigationController?.isNavigationBarHidden = false
       
        
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}


/*   */
