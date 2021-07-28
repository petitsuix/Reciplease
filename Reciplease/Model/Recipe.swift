//
//  InfoEdamamRequest.swift
//  Reciplease
//
//  Created by Richardier on 25/05/2021.
//

import Foundation

struct InfoRecipe: Decodable {
    
    let recipes: [Recipe]
    
    enum CodingKeys: String, CodingKey {
        case recipes = "hits"
    }
}

struct Recipe: Decodable {
    let name: String
    let recipeUrl: String
    let imageUrl: String?
    let numberOfGuests: Double
    let ingredients: [String]
    let totalTime: Double
    
    enum CodingKeys: String, CodingKey {
        case recipe
        case name = "label"
        case recipeUrl = "url"
        case imageUrl = "image"
        case ingredients = "ingredientLines"
        case numberOfGuests = "yield"
        case totalTime
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let recipe = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .recipe)
        name = try recipe.decode(String.self, forKey: .name)
        recipeUrl = try recipe.decode(String.self, forKey: .recipeUrl)
        imageUrl = try recipe.decode(String.self, forKey: .imageUrl)
        ingredients = try recipe.decode([String].self, forKey: .ingredients)
        numberOfGuests = try recipe.decode(Double.self, forKey: .numberOfGuests)
        totalTime = try recipe.decode(Double.self, forKey: .totalTime)
    }
}

extension Recipe {
    init(from recipeEntity: RecipesEntity) {
        self.name = recipeEntity.name ?? ""
        self.recipeUrl = recipeEntity.recipeUrl ?? ""
        self.imageUrl = recipeEntity.imageUrl ?? ""
        if let ingredientsData = recipeEntity.ingredients, let ingredients = try? JSONDecoder().decode([String].self, from: ingredientsData) {
            self.ingredients = ingredients
        } else {
            self.ingredients = []
        }
        self.numberOfGuests = recipeEntity.numberOfGuests
        self.totalTime = recipeEntity.totalTime
    }
}

extension Recipe: Equatable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.name == rhs.name
    }
}

// struct Ingredient: Decodable {
//    let text: String
//    let weight: Double
//    let image: String?
//}

