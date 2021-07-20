//
//  CellDetailsView.swift
//  Reciplease
//
//  Created by Richardier on 29/06/2021.
//

import UIKit

class CellExtraInfoView: UIView {
    
    var recipe: Recipe? {
        didSet {
            refreshData()
        }
    }
    
    // ⬇︎ Extra info about prep time and number of guests
    private var infoStackView = UIStackView()
    
    private var preparationTime = UILabel()
    private var numberOfGuests = UILabel()
    
    private var preparationTimeIcon = UIImageView()
    private var numberOfGuestsIcon = UIImageView()
    
    private var preparationTimeStackView = UIStackView()
    private var numberOfGuestsStackView = UIStackView()
    
    private func refreshData() {
        // date formatter à checker, pas min
        if let numberOfGuests = recipe?.numberOfGuests {
            self.numberOfGuests.text = "\(Int(numberOfGuests))p."
        } else {
            self.numberOfGuests.text = "- "
        }
        
        if let preparationTime = recipe?.preparationTime, recipe?.preparationTime != 0.0 {
            self.preparationTime.text = "\(preparationTime.timeFormatter())"
        } else {
            self.preparationTime.text = "- "
        }
        
        
    }
    
    func configureView() {
        
        //        numberOfGuests.textAlignment = .justified
        numberOfGuests.textAlignment = .center
        numberOfGuestsIcon.image = UIImage(systemName: "person.2.fill")
        
        // FIXME:
        numberOfGuestsIcon.image?.withTintColor(.label) // icones s'affichent toujours en noir
        numberOfGuestsIcon.tintColor = .label
        
        numberOfGuestsStackView.spacing = 4
        numberOfGuestsStackView.distribution = .fillProportionally
        numberOfGuestsStackView.addArrangedSubview(numberOfGuestsIcon)
        numberOfGuestsStackView.addArrangedSubview(numberOfGuests)
        
        preparationTime.textAlignment = .center
        preparationTimeIcon.image = UIImage(systemName: "alarm.fill")
        preparationTimeIcon.tintColor = .label
        preparationTimeStackView.spacing = 4
        preparationTimeStackView.distribution = .fillProportionally
        preparationTimeStackView.addArrangedSubview(preparationTimeIcon)
        preparationTimeStackView.addArrangedSubview(preparationTime)
        
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.layer.masksToBounds = true
        infoStackView.spacing = 3
        infoStackView.alignment = .fill
        infoStackView.axis = .vertical
        infoStackView.addArrangedSubview(numberOfGuestsStackView)
        infoStackView.addArrangedSubview(preparationTimeStackView)
        
        
        addSubview(infoStackView)
        
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        backgroundColor = UIColor.systemOrange
        
        NSLayoutConstraint.activate([
            numberOfGuestsIcon.heightAnchor.constraint(equalToConstant: 17),
            numberOfGuestsIcon.widthAnchor.constraint(equalToConstant: 18),
            preparationTimeIcon.heightAnchor.constraint(equalToConstant: 18),
            preparationTimeIcon.widthAnchor.constraint(equalToConstant: 18),
            numberOfGuestsStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: preparationTimeStackView.leadingAnchor, multiplier: 0),
            infoStackView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            infoStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            infoStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            infoStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4)
        ])
        // TESTS COULEURS:
        //        numberOfGuestsStackView.backgroundColor = .green
        //        preparationTimeStackView.backgroundColor = .blue
    }
}
