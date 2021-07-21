//
//  DetailsViewController.swift
//  Reciplease
//
//  Created by Richardier on 07/06/2021.
//

import UIKit
import SafariServices

class DetailsViewController: UIViewController, SFSafariViewControllerDelegate {
    
    // MARK: - Properties
    
    
    var recipes: [Recipe] = []
    var recipe: Recipe?
    private var isRecipeFavorite = false
    private var cellExtraInfoView = ExtraInfoView()
    
    @IBOutlet weak var recipePicture: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var ingredients: UITextView!
    @IBOutlet weak var getDirectionsButton: UIButton!
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavoriteState()
        setUpFavoriteButton()
        cellExtraInfoView.recipe = recipe
        cellExtraInfoView.configureView()
    }
    
    // MARK: - Methods
    
    private func setUpView() {
        cellExtraInfoView.roundingViewCorners(radius: 3)
        cellExtraInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        getDirectionsButton.roundingButtonCorners(radius: 4)
        
        recipeName.text = recipe?.name
        recipeName.numberOfLines = 0
        if let ingredients = recipe?.ingredients {
            self.ingredients.text = "• \(ingredients.joined(separator: "\n• "))"
        } else {
            self.ingredients.text = "Oops ! Something went wrong while trying to display ingredients list.\n"
            alert("Houston ?", "It seems the ingredients list could not be shown. Try reloading the page or restarting Reciplease !")
        }
        
        if let imageUrl = recipe?.imageUrl {
            recipePicture.loadRecipePhoto(imageUrl)
        } else {
            recipePicture.image = UIImage(named: "ingredients")
        }
        recipePicture.alpha = 0.55
        view.addSubview(cellExtraInfoView)
        
        NSLayoutConstraint.activate([
            cellExtraInfoView.topAnchor.constraint(equalToSystemSpacingBelow: recipePicture.topAnchor, multiplier: 1),
            recipePicture.trailingAnchor.constraint(equalToSystemSpacingAfter: cellExtraInfoView.trailingAnchor, multiplier: 1),
            cellExtraInfoView.leadingAnchor.constraint(equalToSystemSpacingAfter: recipePicture.leadingAnchor, multiplier: 43),
        ])
    }
    
    private func addToFavorite() {
        guard let recipe = recipe else { return }
        do {
            try StorageService.shared.saveRecipe(recipe)
            fetchFavoriteState()
        } catch {
            alert("Well, well...", "It seems this recipe can't be saved")
            print(error)
        }
    }
    
    private func removeFromFavorite() {
        guard let recipe = recipe else { return }
        do {
            try StorageService.shared.deleteRecipe(recipe)
            isRecipeFavorite = false
        } catch {
            print(error) // gérer les erreurs
        }
    }
    
    private func fetchFavoriteState() {
        guard let recipe = recipe else { return }
        let recipes = try? StorageService.shared.loadRecipes()
        guard let _ = recipes?.first(where: { $0 == recipe }) else { isRecipeFavorite = false; return }
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
    
    @objc func openRecipeWebsite() {
        guard let urlString = recipe?.recipeUrl else { return }
        if let url = URL(string:  urlString) {
            let safariViewController = SFSafariViewController(url: url)
            safariViewController.delegate = self
            present(safariViewController, animated: true)
        }
    } // voir methode safari, prensent()
    
    @IBAction func didTapGetDirectionsButton(_ sender: Any) {
        openRecipeWebsite()
    }
}
