//
//  RecipeCell.swift
//  Reciplease
//
//  Created by Richardier on 04/06/2021.
//

import UIKit

class RecipeCell: UITableViewCell {

    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var ingredientsPreviewLabel: UILabel!
    @IBOutlet weak var numberOfGuestsCount: UILabel!
    
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var cellBackgroundImage: UIImageView!
    @IBOutlet weak var numberOfGuestsAndTime: UIView!
    
    var recipe: Recipe? {
        didSet {
            configureCell()
        }
    }
    
    private func configureCell() {
        
        numberOfGuestsAndTime.layer.masksToBounds = true
        numberOfGuestsAndTime.layer.cornerRadius = 5
        numberOfGuestsAndTime.layer.borderWidth = 3
        numberOfGuestsAndTime.layer.borderColor = #colorLiteral(red: 0.9662106633, green: 0.8062962715, blue: 0.5210644391, alpha: 1)
        
        recipeNameLabel.text = recipe?.name
        ingredientsPreviewLabel.text = recipe?.ingredients.joined(separator: ", ")
        totalTimeLabel.text = "\(Int(recipe?.totalTime ?? 15))mn"
        cellBackgroundImage.loadRecipePhoto(recipe?.imageUrl ?? "https://img.cuisineaz.com/680x357/2016-09-08/i60347-ingredients-indispensables-vegetarien.jpg")
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
