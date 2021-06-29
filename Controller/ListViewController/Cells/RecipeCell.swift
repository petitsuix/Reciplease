//
//  RecipeCell.swift
//  Reciplease
//
//  Created by Richardier on 04/06/2021.
//

import UIKit

class RecipeCell: UITableViewCell {
    
    var cellDetailsView = CellDetailsView()
    
    var cellBackgroundImage = UIImageView()
    
    var recipeNameLabel = UILabel()
    var ingredientsPreviewLabel = UILabel()
    var nameAndIngredientsStackView = UIStackView()
    
    var recipe: Recipe? {
        didSet {
            refreshData()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        configureCell()
        cellDetailsView.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureCell()
        cellDetailsView.configureView()
    }
    
    private func refreshData() {
        // TODO :
        cellDetailsView.recipe = recipe
        
        recipeNameLabel.text = recipe?.name
        ingredientsPreviewLabel.text = recipe?.ingredients.joined(separator: ", ")
        // Mettre image dans les assets au lieu de loader à chaque fois, faire if let
        cellBackgroundImage.loadRecipePhoto(recipe?.imageUrl ?? "https://img.cuisineaz.com/680x357/2016-09-08/i60347-ingredients-indispensables-vegetarien.jpg")
    }
    
    private func configureCell() {
        // TODO :
        
        // infoStackView.layer.backgroundColor ou infoStackView.backgroundColor
        // espacement entre recipeNameLabel et ingredientsPreview
        // taille des icones
        
        // faire vue à part a reutiliser dans ecran détails, recipePreview nouvelle class à faire comme recipeCell
        
        // InfoStackView is a horizontal stack view that will contain 2 vertical stack views : one called "iconsStackView" for the number of guests & preparation time icons, and another called "guestsAndPreparationTimeValues for the actual values.
        
        cellBackgroundImage.translatesAutoresizingMaskIntoConstraints = false
        cellBackgroundImage.alpha = 0.55
        cellBackgroundImage.contentMode = .scaleAspectFill
        contentView.addSubview(cellBackgroundImage)
        contentView.sendSubviewToBack(cellBackgroundImage)
        
        recipeNameLabel.font = UIFont.preferredFont(forTextStyle: .headline) // mettre les autres en body ou caption
        recipeNameLabel.textColor = .label
        recipeNameLabel.adjustsFontForContentSizeCategory = true
        // mettre numberOflines
        recipeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // TODO : trouver un moyen d'appliquer adjustFontForContentSizeCategory partout
        ingredientsPreviewLabel.adjustsFontForContentSizeCategory = true
        ingredientsPreviewLabel.font = .italicSystemFont(ofSize: 15)
        ingredientsPreviewLabel.numberOfLines = 0
        ingredientsPreviewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameAndIngredientsStackView.distribution = UIStackView.Distribution.fillProportionally
        nameAndIngredientsStackView.alignment = UIStackView.Alignment.leading
        nameAndIngredientsStackView.spacing = 0
        nameAndIngredientsStackView.contentMode = .scaleToFill
        nameAndIngredientsStackView.translatesAutoresizingMaskIntoConstraints = false
        nameAndIngredientsStackView.axis = .vertical
        
        nameAndIngredientsStackView.addArrangedSubview(recipeNameLabel)
        nameAndIngredientsStackView.addArrangedSubview(ingredientsPreviewLabel)
        
        
        cellDetailsView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(nameAndIngredientsStackView)
        contentView.addSubview(cellDetailsView)
        
        // TESTS COULEURS :
        recipeNameLabel.backgroundColor = .orange
        ingredientsPreviewLabel.backgroundColor = .red
        nameAndIngredientsStackView.backgroundColor = .yellow
        
        NSLayoutConstraint.activate([
            // Background image constraints
            cellBackgroundImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            cellBackgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            cellBackgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            cellBackgroundImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            // ⬇︎ Name & Ingredients stack view constraints
            nameAndIngredientsStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 3.5),
            nameAndIngredientsStackView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 2.5),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: nameAndIngredientsStackView.trailingAnchor, multiplier: 18),
            contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: nameAndIngredientsStackView.bottomAnchor, multiplier: 2),
                // ↳ Ingredients Preview constraints
            ingredientsPreviewLabel.heightAnchor.constraint(equalToConstant: 90),
            
            
            // ⬇︎ Cell details view
//            cellDetailsView.widthAnchor.constraint(equalToConstant: 60),
//            cellDetailsView.heightAnchor.constraint(equalToConstant: 50),
            cellDetailsView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 1),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: cellDetailsView.trailingAnchor, multiplier: 1),
                // ↳ Info icons constraints
//            numberOfGuestsIcon.heightAnchor.constraint(equalToConstant: 8),
//            numberOfGuestsIcon.widthAnchor.constraint(equalToConstant: 8),
//            preparationTimeIcon.heightAnchor.constraint(equalToConstant: 8),
//            preparationTimeIcon.widthAnchor.constraint(equalToConstant: 8)
        ])
        
        //        self.backgroundColor = .orange
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}
