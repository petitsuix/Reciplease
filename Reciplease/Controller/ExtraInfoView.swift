//
//  CellDetailsView.swift
//  Reciplease
//
//  Created by Richardier on 29/06/2021.
//

import UIKit

// Contains extra info about prep time and number of guests

class ExtraInfoView: UIView {
    
    // MARK: - Properties
    
    var recipe: Recipe? {
        didSet {
            refreshData()
        }
    }
    
    private var preparationTime = UILabel()
    private var preparationTimeIcon = UIImageView()
    private var preparationTimeStackView = UIStackView()
    
    private var numberOfGuests = UILabel()
    private var numberOfGuestsIcon = UIImageView()
    private var numberOfGuestsStackView = UIStackView()
   
    private var infoStackView = UIStackView()
    
    // MARK: - Methods
    
    func configureView() {
        configureNumberOfGuestsStackView()
        configurePreparationTimeStackView()
        configureParentStackView()
        
        addSubview(infoStackView)
        layer.borderWidth = 2
        layer.borderColor = #colorLiteral(red: 1, green: 0.6643153543, blue: 0.3359110584, alpha: 0.8514287243)
        backgroundColor = #colorLiteral(red: 0.9518480897, green: 0.7850282788, blue: 0.5619009137, alpha: 1)
        
        activateConstraints()
    }
    
    private func refreshData() {
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
    
    private func configureNumberOfGuestsStackView() {
        numberOfGuests.textAlignment = .center
        numberOfGuestsIcon.image = UIImage(systemName: "person.2.fill")
        numberOfGuestsIcon.tintColor = .label
        numberOfGuestsStackView.spacing = 4
        numberOfGuestsStackView.distribution = .fillProportionally
        numberOfGuestsStackView.addArrangedSubview(numberOfGuestsIcon)
        numberOfGuestsStackView.addArrangedSubview(numberOfGuests)
    }
    
    private func configurePreparationTimeStackView() {
        preparationTime.textAlignment = .center
        preparationTimeIcon.image = UIImage(systemName: "alarm.fill")
        preparationTimeIcon.tintColor = .label
        preparationTimeStackView.spacing = 4
        preparationTimeStackView.distribution = .fillProportionally
        preparationTimeStackView.addArrangedSubview(preparationTimeIcon)
        preparationTimeStackView.addArrangedSubview(preparationTime)
    }
    
    private func configureParentStackView() {
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.layer.masksToBounds = true
        infoStackView.spacing = 3
        infoStackView.alignment = .fill
        infoStackView.axis = .vertical
        infoStackView.addArrangedSubview(numberOfGuestsStackView)
        infoStackView.addArrangedSubview(preparationTimeStackView)
    }
    
    private func activateConstraints() {
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
    }
}
