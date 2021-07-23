//
//  RecipeCell.swift
//  Reciplease
//
//  Created by Richardier on 04/06/2021.
//

import UIKit

class RecipeCell: UITableViewCell {
    
    // MARK: - Properties
    
    private var cellExtraInfoView = ExtraInfoView()
    private var cellBackgroundImage = UIImageView()
    private var recipeNameLabel = UILabel()
    private var ingredientsPreviewLabel = UILabel()
    private var nameAndIngredientsStackView = UIStackView()
    
    var recipe: Recipe? {
        didSet {
            refreshData()
        }
    }
    
    // MARK: - Methods
    
    // FIXME: peut être à enlever ?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        configureCell()
        cellExtraInfoView.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureCell()
        cellExtraInfoView.configureView()
    }
    
    private func configureCell() {
        cellBackgroundImage.translatesAutoresizingMaskIntoConstraints = false
        cellBackgroundImage.alpha = 0.55
        cellBackgroundImage.contentMode = .scaleAspectFill
        contentView.addSubview(cellBackgroundImage)
        contentView.sendSubviewToBack(cellBackgroundImage)
        
        configureNameAndIngredientsLabels()
        configureNameAndIngredientsStackView()
        
        cellExtraInfoView.roundingViewCorners(radius: 3)
        cellExtraInfoView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cellExtraInfoView)
        
        activateCellConstraints()
    }
    
    private func refreshData() {
        cellExtraInfoView.recipe = recipe
        
        recipeNameLabel.text = recipe?.name
        ingredientsPreviewLabel.text = recipe?.ingredients.joined(separator: ", ")
        if let imageUrl = recipe?.imageUrl {
            cellBackgroundImage.loadRecipePhoto((imageUrl))
        } else {
            cellBackgroundImage.image = UIImage(named: "ingredients")
        }
    }
    
    private func configureNameAndIngredientsLabels() {
        recipeNameLabel.adjustsFontForContentSizeCategory = true
        recipeNameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        recipeNameLabel.textColor = .label
        // mettre numberOflines
        recipeNameLabel.numberOfLines = 0
        recipeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        ingredientsPreviewLabel.adjustsFontForContentSizeCategory = true
        ingredientsPreviewLabel.font = .preferredFont(forTextStyle: .caption1)
        ingredientsPreviewLabel.numberOfLines = 2
        ingredientsPreviewLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureNameAndIngredientsStackView() {
        nameAndIngredientsStackView.distribution = UIStackView.Distribution.fillProportionally
        nameAndIngredientsStackView.alignment = UIStackView.Alignment.leading
        nameAndIngredientsStackView.spacing = 0
        nameAndIngredientsStackView.contentMode = .scaleAspectFit
        nameAndIngredientsStackView.translatesAutoresizingMaskIntoConstraints = false
        nameAndIngredientsStackView.axis = .vertical
        
        nameAndIngredientsStackView.addArrangedSubview(recipeNameLabel)
        nameAndIngredientsStackView.addArrangedSubview(ingredientsPreviewLabel)
        contentView.addSubview(nameAndIngredientsStackView)
    }
    
    private func activateCellConstraints() {
        NSLayoutConstraint.activate([
            // Background image
            cellBackgroundImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            cellBackgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            cellBackgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            cellBackgroundImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            // Name & Ingredients stack view
            nameAndIngredientsStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 3.5),
            nameAndIngredientsStackView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 2.5),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: nameAndIngredientsStackView.trailingAnchor, multiplier: 18),
            contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: nameAndIngredientsStackView.bottomAnchor, multiplier: 2),
            
            // Cell extra info view
            cellExtraInfoView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 1),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: cellExtraInfoView.trailingAnchor, multiplier: 1),
            cellExtraInfoView.leadingAnchor.constraint(lessThanOrEqualToSystemSpacingAfter: nameAndIngredientsStackView.trailingAnchor, multiplier: 8.5)
        ])
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
