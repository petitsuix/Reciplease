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
    
    var recipe: Recipe?
    private var isRecipeFavorite = false
    private var extraInfoView = ExtraInfoView() // Small inset. Shows preparation time's and nb of guests' values and icons
    
    @IBOutlet weak var recipePicture: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var ingredients: UITextView!
    @IBOutlet weak var getDirectionsButton: UIButton!
    
    // MARK: - View life cycle methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavoriteState()
        setUpFavoriteButton()
        extraInfoView.recipe = recipe
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    // MARK: - IBAction Methods
    
    @IBAction func didTapGetDirectionsButton(_ sender: Any) {
        openRecipeWebsite()
    }
    
    // MARK: - Methods
    
    private func setUpView() {
        setUpRecipeDetailsAndPicture()
        
        extraInfoView.configureView()
        extraInfoView.translatesAutoresizingMaskIntoConstraints = false
        extraInfoView.roundingViewCorners(radius: 3)
        getDirectionsButton.titleLabel?.adjustsFontForContentSizeCategory = true
        getDirectionsButton.roundingButtonCorners(radius: 4)
        view.addSubview(extraInfoView)
        
        activateConstraints()
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
    
    private func setUpRecipeDetailsAndPicture() {
        recipeName.adjustsFontForContentSizeCategory = true
        recipeName.text = recipe?.name
        recipeName.font = UIFont.preferredFont(forTextStyle: .title1)
        recipeName.numberOfLines = 0
        if let ingredients = recipe?.ingredients {
            self.ingredients.text = "??? \(ingredients.joined(separator: "\n??? "))"
        } else {
            print("Error: recipe.ingredients is nil")
            alert("Houston ?", "It seems the ingredients list could not be shown. Try reloading the page or restarting Reciplease !")
        }
        if let imageUrl = recipe?.imageUrl {
            recipePicture.loadRecipePhoto(imageUrl)
        } else {
            recipePicture.image = UIImage(named: "ingredients")
        }
        recipePicture.alpha = 0.55
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            extraInfoView.topAnchor.constraint(equalToSystemSpacingBelow: recipePicture.topAnchor, multiplier: 1),
            recipePicture.trailingAnchor.constraint(equalToSystemSpacingAfter: extraInfoView.trailingAnchor, multiplier: 1),
            extraInfoView.leadingAnchor.constraint(lessThanOrEqualToSystemSpacingAfter: recipePicture.leadingAnchor, multiplier: 43)
        ])
    }
    
    private func addToFavorite() {
        guard let recipe = recipe else { return }
        do {
            try StorageService.shared.saveRecipe(recipe)
            fetchFavoriteState()
        } catch {
            print(ServiceError.savingError)
            alert("Well, well...", "It seems this recipe can't be saved")
        }
    }
    
    private func removeFromFavorite() {
        guard let recipe = recipe else { return }
        do {
            try StorageService.shared.deleteRecipe(recipe)
            isRecipeFavorite = false
        } catch {
            print(ServiceError.deletingError)
            alert("Oops...", "Could not reach and delete this recipe")
        }
    }
    
    // MARK: - objc Methods
    
    @objc func toggleFavorite() {
        if isRecipeFavorite == true {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
            removeFromFavorite()
            isRecipeFavorite = false
        } else {
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
    }
}
