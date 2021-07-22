//
//  SearchResultsViewController.swift
//  Reciplease
//
//  Created by Richardier on 27/05/2021.
//

import UIKit

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
                activityIndicator.startAnimating()
                print("loading")
            case .empty :
                displayNoResultView()
                print("empty")
            case .error :
                alert("Oops...", "Something went wrong,please try again")
                print("error")
            case .showData(let recipes) :
                self.recipes = recipes
                tableView.reloadData()
                tableView.isHidden = false
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataFromCorrespondingDataMode()
    }
    
    // MARK: - Methods
    
    private func configureView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        title = dataMode.title // Adapting title according to the dataMode we're in
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func resetState() {
        tableView.isHidden = true
        activityIndicator.stopAnimating()
    }

    private func getDataFromCorrespondingDataMode() {
        if dataMode == .coreData {
            do {
                viewState = .loading // triggers activity indicator
                recipes = try StorageService.shared.loadRecipes()
                self.activityIndicator.stopAnimating()
                if recipes.isEmpty {
                    viewState = .empty // displays "no results found" view
                } else {
                    viewState = .showData(recipes)
                }
            } catch {
                print(error)
            }
        } else { // If dataMode == .api
            fetchRecipes()
        }
    }
    
    private func fetchRecipes() {
        viewState = .loading // Triggers activity indicator
        networkService.fetchData(for: ingredients) { [weak self] result in // Calling data request. Completion expecting a result of type Result<success, failure>
            guard let self = self else { return }
            DispatchQueue.main.async { // Allows to modify UI from main thread
                switch result {
                case .success(let infoEdamamRequest):
                    if infoEdamamRequest.recipes.isEmpty {
                        self.viewState = .empty // Displays "no results found" view
                    } else {
                        self.recipes = infoEdamamRequest.recipes
                        self.viewState = .showData(infoEdamamRequest.recipes)
                    }
                case .failure(let error):
                    self.alert("Houston ?", "Something went wrong while trying to load recipes. Perhaps you should give it another try ?")
                    print(error)
                }
            }
        }
    }
    
    // ⬇︎ Coded programmatically to be used in both Favorites and Search Results list views. Displays a simple view with a "nothing to show" message when their tableview is empty. 
    private func displayNoResultView() {
        let noResultTextView = UITextView.init(frame: self.view.frame)
        noResultTextView.text = "\n\n\n\n\nOops, nothing to show here !"
        noResultTextView.font = UIFont.preferredFont(forTextStyle: .subheadline)
        noResultTextView.textColor = .systemGray
        noResultTextView.textAlignment = .center
        noResultTextView.isEditable = false
        noResultTextView.adjustsFontForContentSizeCategory = true
        view.addSubview(noResultTextView)
    }
    
    private func displayRecipeDetailFor(_ recipe: Recipe) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsVC") as? DetailsViewController else { return } // Instantiating the given storyboard
        detailsViewController.recipe = recipe
        navigationController?.isNavigationBarHidden = false
        navigationController?.pushViewController(detailsViewController, animated: true) // Pushing detailsViewController
    }
    
    @objc func dismissListViewController() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - TableView
extension ListViewController: UITableViewDataSource, UITableViewDelegate {

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
