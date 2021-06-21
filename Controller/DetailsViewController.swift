//
//  DetailsViewController.swift
//  Reciplease
//
//  Created by Richardier on 07/06/2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    var recipes: [Recipe] = []
    var recipe: Recipe?
    private var isRecipeFavorite = false
    
    @IBOutlet weak var recipePicture: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var ingredients: UITextField!
    @IBOutlet weak var getDirectionsButton: UIButton!
    
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // mettre dans methode setUpView()
        fetchFavoriteState()
        setUpFavoriteButton()
        recipeName.text = recipe?.name
        ingredients.text = recipe?.ingredients.joined(separator: ", ") // transformer ces deux lignes en une méthode
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Ne pas oublier super si utilisé
    }
    
    
    // MARK: - Methods
    
    private func addToFavorite() {
        guard let recipe = recipe else { return }
        do {
            try StorageService().saveRecipe(recipe)
            fetchFavoriteState()
            
        } catch {
            print(error) // créer une vrai uialert "pasde sauvegade possible"
        }
    }
    
    private func removeFromFavorite() {
        guard let recipe = recipe else { return }
        do {
            try StorageService().deleteRecipe(recipe)
            
            //            fetchFavoriteState()
            isRecipeFavorite = false
            
        } catch {
            print(error)
        }
    }
    
    private func fetchFavoriteState() {
        guard let recipe = recipe else { return }
        let recipes = try? StorageService().loadRecipes()
        guard let _ = recipes?.first(where: { $0 == recipe }) else { return }
        isRecipeFavorite = true
    }
    
    private func setUpFavoriteButton() {
        let navBarRightItem = UIBarButtonItem(
            image: UIImage(systemName: isRecipeFavorite ? "heart.fill" : "heart"),
            style: .plain,
            target: self,
            action: #selector(toggleFavorite))
        navigationItem.rightBarButtonItem = navBarRightItem
    }
    
    @objc func toggleFavorite() {
        // vérifie si c'est en favoris, add to favorite ou remove from favorite <- gère l'entity
        if isRecipeFavorite {
            // suppression du favori
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
            removeFromFavorite()
            isRecipeFavorite = false
        } else if isRecipeFavorite == false {
            // ajout du favori
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
            addToFavorite()
            isRecipeFavorite = true
        }
    }
    
    @objc func openRecipeWebsite() {} // voir methode safari, prensent()
    
}
