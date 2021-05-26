//
//  InfoEdamamRequest.swift
//  Reciplease
//
//  Created by Richardier on 25/05/2021.
//

import Foundation

struct InfoEdamamRequest: Decodable {
    var count: Double
    var hits: [Hit]
}

struct Hit: Decodable {
    var recipe: Recipe
}

struct Recipe: Decodable {
    var label: String
    var image: String
    var yield: Double
    var ingredientLines: [String]
    var ingredients: [Ingredient]
}

struct Ingredient: Decodable {
    var text: String
    var weight: Double
}
