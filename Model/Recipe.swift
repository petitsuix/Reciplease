//
//  InfoEdamamRequest.swift
//  Reciplease
//
//  Created by Richardier on 25/05/2021.
//

import Foundation

struct InfoEdamamRequest: Decodable {
    
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
    let totalTime: Double?
    
    enum CodingKeys: String, CodingKey {
        case name = "label"
        case recipeUrl = "url"
        case recipe
        case imageUrl = "image"
        case numberOfGuests = "yield"
        case ingredients = "ingredientLines"
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
        let decodedTotalTime = try recipe.decode(Double.self, forKey: .totalTime)
        totalTime = decodedTotalTime == 0.0 ? nil : decodedTotalTime
    }
}

extension Recipe {
    init(from recipeEntity: RecipesEntity) {
        self.name = recipeEntity.name ?? ""
        self.recipeUrl = recipeEntity.recipeUrl ?? ""
        self.imageUrl = recipeEntity.imageUrl ?? ""
        self.ingredients = []
//        self.ingredients = recipeEntity.ingredients // faire l'inverse de joined()
        self.numberOfGuests = recipeEntity.numberOfGuests
        self.totalTime = recipeEntity.totalTime
    }
}

extension Recipe: Equatable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.name == rhs.name
        // Ajouter comparaison par rapport à l'URL aussi, peut-être ? pour etre sur que ce soit des recettes différentes
    }
}

struct Ingredient: Decodable {
    let text: String
    let weight: Double
    let image: String?
}

