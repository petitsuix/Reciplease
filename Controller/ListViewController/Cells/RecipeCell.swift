//
//  RecipeCell.swift
//  Reciplease
//
//  Created by Richardier on 04/06/2021.
//

import UIKit

class RecipeCell: UITableViewCell {
    
    var cellBackgroundImage = UIImageView()
    
    // ⬇︎ Recipe name and ingredients preview
    var nameAndIngredientsStackView = UIStackView()
    var recipeNameLabel = UILabel()
    var ingredientsPreviewLabel = UILabel()
    
    // ⬇︎ Extra info about prep time and number of guests
    var infoStackView = UIStackView()
        // icons
    var icons = UIStackView()
    var numberOfGuestsIcon = UIImageView(image: UIImage(systemName: "person.2.fill"))
    var preparationTimeIcon = UIImageView(image: UIImage(systemName: "alarm.fill"))
        // values
    var values = UIStackView()
    var numberOfGuests = UILabel()
    var preparationTime = UILabel()
    
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
        // TODO :
        // recipePreview.recipe = recipe
        
        
        // faire if let si on connait pas ces valeurs, ne pas afficher ou unknown
        numberOfGuests.text = "\(Int(recipe?.numberOfGuests ?? 4))"
        preparationTime.text = "\(Int(recipe?.preparationTime ?? 15))'" // date formatter à checker, pas min
        
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
        
        nameAndIngredientsStackView.distribution = UIStackView.Distribution.fillProportionally
        nameAndIngredientsStackView.alignment = UIStackView.Alignment.leading
        nameAndIngredientsStackView.spacing = 0
        nameAndIngredientsStackView.contentMode = .scaleToFill
        nameAndIngredientsStackView.translatesAutoresizingMaskIntoConstraints = false
        nameAndIngredientsStackView.axis = .vertical
        
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
        
        nameAndIngredientsStackView.addArrangedSubview(recipeNameLabel)
        nameAndIngredientsStackView.addArrangedSubview(ingredientsPreviewLabel)
        
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.layer.masksToBounds = true
        infoStackView.layer.cornerRadius = 5
        infoStackView.layer.borderWidth = 3
        infoStackView.layer.borderColor = #colorLiteral(red: 0.9662106633, green: 0.7892381697, blue: 0.4303233427, alpha: 1)
        infoStackView.backgroundColor = #colorLiteral(red: 0.9662106633, green: 0.8062962715, blue: 0.5210644391, alpha: 1)
        infoStackView.spacing = 0
        infoStackView.distribution = .fillEqually
        infoStackView.axis = .horizontal
        
        icons.distribution = .fillProportionally
        icons.alignment = .center
        icons.spacing = 0
        icons.contentMode = .scaleToFill
        icons.translatesAutoresizingMaskIntoConstraints = false
        icons.axis = .vertical
        
        values.distribution = .fillEqually
        values.alignment = .center
        values.spacing = 0
        values.contentMode = .scaleToFill
        values.translatesAutoresizingMaskIntoConstraints = false
        values.axis = .vertical
        
        preparationTime.font = .systemFont(ofSize: 15.0)
        numberOfGuests.font = .systemFont(ofSize: 15.0)
        
        contentView.addSubview(nameAndIngredientsStackView)
        contentView.addSubview(infoStackView)
        infoStackView.addArrangedSubview(icons)
        infoStackView.addArrangedSubview(values)
        icons.addArrangedSubview(numberOfGuestsIcon)
        icons.addArrangedSubview(preparationTimeIcon)
        values.addArrangedSubview(numberOfGuests)
        values.addArrangedSubview(preparationTime)
        
        
        
        // TESTS COULEURS:
        nameAndIngredientsStackView.backgroundColor = .yellow
        recipeNameLabel.backgroundColor = .orange
        ingredientsPreviewLabel.backgroundColor = .red
        
        
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
            
            
            // ⬇︎ Info stack view
            infoStackView.widthAnchor.constraint(equalToConstant: 60),
            infoStackView.heightAnchor.constraint(equalToConstant: 50),
            infoStackView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 1),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: infoStackView.trailingAnchor, multiplier: 1),
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
