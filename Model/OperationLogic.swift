//
//  OperationLogic.swift
//  Reciplease
//
//  Created by Richardier on 26/05/2021.
//

import Foundation


class OperationLogic {
    
    var ingredient: String = ""
    
    var ingredientsList: [String] = []
    
    var searchIngredientsTextField: String = "" {
        didSet {
            notifyIngredientsListUpdated()
        }
    }
    
    var ingredientsListTextView: String = "" {
        didSet {
            notifyIngredientsListUpdated()
        }
    }
    
    func ingredientsListFormatted() -> String {
        return ingredientsList.joined(separator: ",")
    }
    
    func addIngredient(_ ingredient: String) {
        guard searchIngredientsTextField != "" else { return notifyMissingIngredient() }
        ingredientsListTextView.append("• \(ingredient)\n")
        ingredientsList.append(ingredient)
    }
    
    func cleanSearchBar() {
        searchIngredientsTextField = ""
    }
    
    func cleanIngredientsList() {
        ingredientsListTextView = ""
        ingredientsList.removeAll()
    }
    
    private func notifyIngredientsListUpdated() {
        let notificationName = NSNotification.Name(rawValue: "ingredients updated")
        let notification = Notification(name: notificationName)
        NotificationCenter.default.post(notification)
    }
    
    private func notifyMissingIngredient() {
        let notificationName = NSNotification.Name(rawValue: "alert missing ingredient")
        let notification = Notification(name: notificationName)
        NotificationCenter.default.post(notification)
    }
}
