//
//  FavoriteCell.swift
//  Reciplease
//
//  Created by Richardier on 21/06/2021.
//

import UIKit

class FavoriteCell: UITableViewCell {


    @IBOutlet weak var recipeName: UILabel!
    
    var recipe: Recipe? {
        didSet {
            configureCell()
        }
    }
    
    private func configureCell() {
        
//        numberOfGuestsAndTime.layer.masksToBounds = true
//        numberOfGuestsAndTime.layer.cornerRadius = 5
//        numberOfGuestsAndTime.layer.borderWidth = 3
//        numberOfGuestsAndTime.layer.borderColor = #colorLiteral(red: 0.9662106633, green: 0.8062962715, blue: 0.5210644391, alpha: 1)
//
//        numberOfGuestsCount.text = "\(Int(recipe?.numberOfGuests ?? 4))"
        recipeName.text = recipe?.name
//        ingredientsPreviewLabel.text = recipe?.ingredients.joined(separator: ", ")
//        totalTimeLabel.text = "\(Int(recipe?.totalTime ?? 15))mn"
//        cellBackgroundImage.loadRecipePhoto(recipe?.imageUrl ?? "https://img.cuisineaz.com/680x357/2016-09-08/i60347-ingredients-indispensables-vegetarien.jpg")
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
