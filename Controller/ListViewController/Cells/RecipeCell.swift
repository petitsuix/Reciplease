//
//  RecipeCell.swift
//  Reciplease
//
//  Created by Richardier on 04/06/2021.
//

import UIKit

class RecipeCell: UITableViewCell {
    
    var recipeNameLabel = UILabel()
    var ingredientsPreviewLabel = UILabel()
    var numberOfGuestsCount = UILabel()
    
    var totalTimeLabel = UILabel()
    var cellBackgroundImage = UIImageView()
    var numberOfGuestsAndTime = UIView()
    
//    var cellView = UIView()
    
    var recipe: Recipe? {
        didSet {
            refreshData()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureCell()
    }
    
    
    private func refreshData() {
        //recipePreview.recipe = recipe
        // faire if let si on connait pas ces valeurs, ne pas afficher ou unknown
        numberOfGuestsCount.text = "\(Int(recipe?.numberOfGuests ?? 4))"
        totalTimeLabel.text = "\(Int(recipe?.totalTime ?? 15))mn" // date formatter à checker, pas min

        recipeNameLabel.text = recipe?.name
        ingredientsPreviewLabel.text = recipe?.ingredients.joined(separator: ", ")
        // Mettre image dans les assets au lieu de loader à chaque fois, faire if let
        cellBackgroundImage.loadRecipePhoto(recipe?.imageUrl ?? "https://img.cuisineaz.com/680x357/2016-09-08/i60347-ingredients-indispensables-vegetarien.jpg")

    }
    private func configureCell() {
        // faire vue à part a reutiliser dans ecran détails, recipePreview nouvelle class à faire comme recipeCell
        numberOfGuestsAndTime.translatesAutoresizingMaskIntoConstraints = false
        numberOfGuestsAndTime.layer.masksToBounds = true
        numberOfGuestsAndTime.layer.cornerRadius = 5
        numberOfGuestsAndTime.layer.borderWidth = 3
        numberOfGuestsAndTime.layer.borderColor = #colorLiteral(red: 0.9662106633, green: 0.8062962715, blue: 0.5210644391, alpha: 1)
        contentView.addSubview(numberOfGuestsAndTime)
        
        numberOfGuestsCount.translatesAutoresizingMaskIntoConstraints = false
        numberOfGuestsAndTime.addSubview(numberOfGuestsCount)
        
        totalTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfGuestsAndTime.addSubview(totalTimeLabel)
        
        recipeNameLabel.font = UIFont.preferredFont(forTextStyle: .headline) // mettre les autres en body ou caption
        recipeNameLabel.textColor = .label
        recipeNameLabel.adjustsFontForContentSizeCategory = true
        // mettre numberOflines
        recipeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(recipeNameLabel)
        
        ingredientsPreviewLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(ingredientsPreviewLabel)
        

        
        cellBackgroundImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cellBackgroundImage)
        
        NSLayoutConstraint.activate([
            recipeNameLabel.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 1.5),
            recipeNameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1.0),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: recipeNameLabel.trailingAnchor, multiplier: 1.0),
            contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: recipeNameLabel.bottomAnchor, multiplier: 1.5)
        ])
        
        //        self.backgroundColor = .orange

        
        // baisser opacité
        // mettre la photo en .fill
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
