//
//  DetailsViewController.swift
//  Reciplease
//
//  Created by Richardier on 07/06/2021.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var recipePicture: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var ingredients: UITextField!
    @IBOutlet weak var getDirectionsButton: UIButton!
    
    // let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var recipes: [Recipe] = []
    var recipe: Recipe?
    var isRecipeFavorite = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
       // print(recipe)
//        fetchFavoriteState()
        setUpFavoriteButton()
        // mettre dans methode setUpView()
        recipeName.text = recipe?.name
        ingredients.text = recipe?.ingredients.joined(separator: ", ")
        
    }
    
    private func addToFavorite() {
        guard let recipe = recipe else { return }
        do {
            try StorageService().saveRecipe(recipe)
            fetchFavoriteState()
        
        } catch {
            print(error) // créer une vrai uialert "pasde sauvegade possible"
        }
    }
    
    func removeFromFavorite() {
//        guard let recipe = recipe else { return }
//        do {
//            try StorageService().deleteRecipe(recipe)
//            fetchFavoriteState()
//
//        } catch {
//            print(error)
//        }
    }
    
    private func fetchFavoriteState() {
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
        if isRecipeFavorite == true {
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
