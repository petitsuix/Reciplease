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
    var infoStackView = UIStackView()
    // icons
    // values
    
    
    var preparationTime = UILabel()
    var numberOfGuests = UILabel()
    
    
    func refreshData() {
        // faire if let si on connait pas ces valeurs, ne pas afficher ou unknown
         // date formatter à checker, pas min
        numberOfGuests.attributedText = textWithAttachedIcon(imageName: "person.2.fill", text: " \(Int(recipe?.numberOfGuests ?? 4))")
        preparationTime.attributedText = textWithAttachedIcon(imageName: "alarm.fill", text: " \(Int(recipe?.preparationTime ?? 15))'")
    }
    
    func textWithAttachedIcon(imageName: String, text: String) -> NSMutableAttributedString {
        // Create Attachment
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: imageName)?.withTintColor(.label, renderingMode: .alwaysOriginal)
        // Set bound to reposition
        let imageOffsetY: CGFloat = -5.0
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        // Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)
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

        preparationTime.textAlignment = .natural
        numberOfGuests.textAlignment = .natural
        // essayer content mode et autres
        
        
//      layer.masksToBounds = true
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
