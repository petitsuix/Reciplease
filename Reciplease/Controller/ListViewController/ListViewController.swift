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
    
    // MARK: - Properties
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    var ingredients: String = ""
    var recipes: [Recipe] = []
    // peut-être poser ici un didSet qui check si recipes est empty
    var dataMode: DataMode = .coreData
    var networkService = NetworkService()
    
    private var viewState: State<[Recipe]> = .loading {
        didSet {
            resetState()
            switch viewState {
            case .loading :
                // ajouter/créer activity indicator ici et ajouter un "loading" dans un UIViewCustom ou y'a ces deux objets
                resultsTableView.isHidden = true
                activityIndicator.startAnimating()
                print("loading")
            case .empty :
                // afficher une petite vue ou label ou alerte pour signifier qu'il n'y a rien
                activityIndicator.stopAnimating()
                resultsTableView.isHidden = true
                displayNoResultView()
                print("empty")
            case .error :
                activityIndicator
                    .stopAnimating()
                print("error")// présenter une alerte
            case .showData(let recipes) :
                activityIndicator.stopAnimating()
                self.recipes = recipes
                resultsTableView.reloadData()
                resultsTableView.isHidden = false
            }
        }
    }
    
    @IBOutlet weak var resultsTableView: UITableView!
    
    // MARK: - View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = dataMode.title
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if dataMode == .coreData {
            do {
                viewState = .loading
                recipes = try StorageService.shared.loadRecipes()
                self.activityIndicator.stopAnimating()
                if recipes.isEmpty {
                    viewState = .empty
                } else {
                    viewState = .showData(recipes)
                }
            } catch {
                print(error)
            }
        } else {
            fetchRecipes()
        }
        resultsTableView.reloadData()
    }
    
    // MARK: - Methods
    
    private func resetState() {
    }
    
    private func fetchRecipes() {
        viewState = .loading
        networkService.fetchData(for: ingredients) { result in
            switch result {
            case .success(let infoEdamamRequest):
                if infoEdamamRequest.recipes.isEmpty {
                    self.viewState = .empty
                } else {
                    self.recipes = infoEdamamRequest.recipes
                    self.viewState = .showData(infoEdamamRequest.recipes)
                    print(infoEdamamRequest)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func displayNoResultView() {
        let noResultTextView = UITextView.init(frame: view.frame)
        noResultTextView.text = "\n\n\n\n\nOops, nothing to show here !"
        noResultTextView.font = UIFont.preferredFont(forTextStyle: .subheadline)
        noResultTextView.textColor = .systemGray
        noResultTextView.textAlignment = .center
        view.insertSubview(noResultTextView, at: 0)
    }
    
    private func displayRecipeDetailFor(_ recipe: Recipe) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsVC") as? DetailsViewController else { return }
        detailsViewController.recipe = recipe
        navigationController?.isNavigationBarHidden = false
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    @objc func dismissListViewController() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - TableView
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // returning the cell depending on dataMode
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell") as? RecipeCell else {
            assertionFailure("Dequeue TableViewCell is of wrong type")
            return UITableViewCell()
        }
        cell.recipe = recipes[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard dataMode == .coreData else { return }
        if editingStyle == .delete {
            // Delete the recipe in the core data "memory"
            do {
                try StorageService.shared.deleteRecipe(recipes[indexPath.row])
            } catch  {
                print("error")
            }
            // Then delete the row from the data source
            recipes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        if recipes.isEmpty {
            viewState = .empty
        }
    }
}
