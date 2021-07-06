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
    
    private func refreshData() {
        // date formatter à checker, pas min
        if let numberOfGuests = recipe?.numberOfGuests {
            self.numberOfGuests.attributedText = textWithAttachedIcon(imageName: "person.2.fill", text: " \(Int(numberOfGuests))")
        } else {
            self.numberOfGuests.attributedText = textWithAttachedIcon(imageName: "person.2.fill", text: "  -")
        }
        
        if let preparationTime = recipe?.preparationTime {
            self.preparationTime.attributedText = textWithAttachedIcon(imageName: "alarm.fill", text: " \(Int(preparationTime))")
        } else {
            self.preparationTime.attributedText = textWithAttachedIcon(imageName: "alarm.fill", text: "  -")
        }
    }
    
    private func textWithAttachedIcon(imageName: String, text: String) -> NSMutableAttributedString {
        // Create attachment
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: imageName)?.withTintColor(.label, renderingMode: .alwaysOriginal)
        // Setting bounds
        if let imageAttachment = attachment.image {
            attachment.bounds = CGRect(x: 0, y: -3, width: imageAttachment.size.width, height: imageAttachment.size.height)
        }
        // Create string with attachment
        let attachmentString = NSAttributedString(attachment: attachment)
        // Initialize mutable string
        let completeText = NSMutableAttributedString(string: "")
        // Add image to mutable string
        completeText.append(attachmentString)
        // Add your text to mutable string
        let textAfterIcon = NSAttributedString(string: text)
        completeText.append(textAfterIcon)
        return completeText
    }
    
    func configureView() {
        numberOfGuests.textAlignment = .justified
        preparationTime.textAlignment = .justified
        
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray.cgColor
        backgroundColor = UIColor.systemGray3
        
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.layer.masksToBounds = true
        infoStackView.spacing = 0
        infoStackView.distribution = .fillEqually
        infoStackView.axis = .vertical
        infoStackView.addArrangedSubview(numberOfGuests)
        infoStackView.addArrangedSubview(preparationTime)
        
        addSubview(infoStackView)
        
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            infoStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            infoStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            infoStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4)
        ])
        // TESTS COULEURS:
        infoStackView.backgroundColor = .red
    }
}
