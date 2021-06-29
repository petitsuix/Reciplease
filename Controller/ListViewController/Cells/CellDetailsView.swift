//
//  CellDetailsView.swift
//  Reciplease
//
//  Created by Richardier on 29/06/2021.
//

import UIKit

class CellDetailsView: UIView {
    
    var recipe: Recipe? {
        didSet {
            refreshData()
        }
    }
    
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
    
    func refreshData() {
        // faire if let si on connait pas ces valeurs, ne pas afficher ou unknown
         // date formatter à checker, pas min
        numberOfGuests.text = "\(Int(recipe?.numberOfGuests ?? 4))"
        preparationTime.text = "\(Int(recipe?.preparationTime ?? 15))'"
    }
    
    func configureView() {
        
        icons.distribution = .fillProportionally
        icons.alignment = .center
        icons.spacing = 0
        icons.contentMode = .scaleToFill
        icons.translatesAutoresizingMaskIntoConstraints = false
        icons.axis = .vertical
        icons.addArrangedSubview(numberOfGuestsIcon)
        icons.addArrangedSubview(preparationTimeIcon)
        
        values.distribution = .fillEqually
        values.alignment = .center
        values.spacing = 0
        values.contentMode = .scaleToFill
        values.translatesAutoresizingMaskIntoConstraints = false
        values.axis = .vertical
        values.addArrangedSubview(numberOfGuests)
        values.addArrangedSubview(preparationTime)
        
        preparationTime.font = .systemFont(ofSize: 15.0)
        numberOfGuests.font = .systemFont(ofSize: 15.0)
        
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.layer.masksToBounds = true
        infoStackView.layer.cornerRadius = 5
        infoStackView.layer.borderWidth = 3
        infoStackView.spacing = 0
        infoStackView.distribution = .fillEqually
        infoStackView.axis = .horizontal
        infoStackView.addArrangedSubview(icons)
        infoStackView.addArrangedSubview(values)
        
        self.backgroundColor = #colorLiteral(red: 0.9662106633, green: 0.8062962715, blue: 0.5210644391, alpha: 1)
        self.layer.borderColor = #colorLiteral(red: 0.9662106633, green: 0.7892381697, blue: 0.4303233427, alpha: 1)
        self.addSubview(infoStackView)
        
        
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 0),
            infoStackView.bottomAnchor.constraint(equalToSystemSpacingBelow: self.bottomAnchor, multiplier: 0),
            infoStackView.trailingAnchor.constraint(equalToSystemSpacingAfter: self.trailingAnchor, multiplier: 0),
            infoStackView.trailingAnchor.constraint(equalToSystemSpacingAfter: self.trailingAnchor, multiplier: 0)
        ])
        
        // TESTS COULEURS:
        self.backgroundColor = .cyan
        
    }
    
    
  
    
    
    
    
}
