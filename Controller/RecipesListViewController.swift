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

class RecipesListViewController: UIViewController, UINavigationBarDelegate { // pas resultat de recherche en particulier, faire searchlist et recipelist
    
    var operationLogic = OperationLogic()
    
    var recipes: [Recipe] = []
    var dataMode: DataMode = .api
    
    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var resultsNavigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // title
        resultsNavigationBar.delegate = self
        let navItem = UINavigationItem()
        navItem.title = "\(recipes.count) results"
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(self.goBack))
        resultsNavigationBar.items = [navItem]
        view.addSubview(resultsNavigationBar)

        title = dataMode.title
        resultsTableView.dataSource = self
        //if dataMode = coreData, lit la BDD, recipes = coreDataservice.loadRecipes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resultsTableView.reloadData()
    }
    
    @objc func goBack(){
        dismiss(animated: true, completion: nil)
    }
}

extension RecipesListViewController: UITableViewDataSource, UITableViewDelegate {
    // faire les cellCustom dans le code, faire recipeCell
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)
        let recipe = recipes[indexPath.row]
        cell.textLabel?.text = recipe.name
        //cell.recipe = recipe
        return cell
    }
}
