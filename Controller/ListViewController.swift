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

enum State<Data> {
    case loading
    case empty
    case error
    case showData(Data)
}

class ListViewController: UIViewController, UINavigationBarDelegate {
    
    var ingredients: String = ""
    var recipes: [Recipe] = [] // peut-être poser ici un didSet qui check si recipes est empty
    var dataMode: DataMode = .coreData
    var storageService = StorageService()
    var viewState: State<[Recipe]> = .loading {
        didSet {
            resetState()
            switch viewState {
            case .loading :
               // searchRecipesButton.isHidden = true
               // searchActivityIndicator.isHidden = false
            print("loading")
            case .empty :
                // afficher une petite vue ou label ou alerte pour signifier qu'il n'y a rien
            print("empty")
            case .error :
                print("error")// présenter une alerte
            case .showData(let recipes) :
                self.recipes = recipes
                resultsTableView.reloadData()
            }
        }
    }

    
    @IBOutlet weak var resultsTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = dataMode.title
        
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        resultsTableView.reloadData()
        if dataMode == .coreData {
            do {
                recipes = try storageService.loadRecipes()
            } catch {
                print(error)
            }
        } else {
            fetchRecipes()
        } // mettre dans le viewwillappear
        resultsTableView.reloadData()

    }
    
    private func resetState() {
    }
    
    func fetchRecipes() {
        viewState = .loading
        RecipeService.shared.fetchData(for: ingredients) { result in
            switch result {
            case .success(let infoEdamamRequest) where infoEdamamRequest.recipes.isEmpty :
                self.viewState = .empty
            case .success(let infoEdamamRequest):
                print(infoEdamamRequest)
                self.viewState = .showData(infoEdamamRequest.recipes)
                self.recipes = infoEdamamRequest.recipes
            case .failure(let error):
                print(error)
            }
        }
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
        // returning the cell depending on dataMode
        if dataMode == .api {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell") as? RecipeCell else {
                assertionFailure("Dequeue TableViewCell is of wrong type")
                return UITableViewCell()
            }
            cell.recipe = recipes[indexPath.row]
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell") as? FavoriteCell else {
                assertionFailure("Dequeue TableViewCell is of wrong type")
                return UITableViewCell()
            }
            cell.recipe = recipes[indexPath.row]
            return cell
        }
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
