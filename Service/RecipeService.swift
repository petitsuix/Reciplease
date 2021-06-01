//
//  EdamamService.swift
//  Reciplease
//
//  Created by Richardier on 25/05/2021.
//

import UIKit
import Alamofire

class RecipeService {
    
    static let shared = RecipeService()
    
    private init() {}
    
    let baseUrl = "https://api.edamam.com/search?"
    
    func fetchData(for ingredients: String, completion: @escaping (Result<InfoEdamamRequest, AFError>) -> Void) {
        let url = "\(baseUrl)app_id=\(AppId.appId)&app_key=\(ApiKey.edamamKey)&q=\(ingredients)"
        let encodedUrl = url.replacingOccurrences(of: " ", with: "+")
        print(encodedUrl)
        Session.default.request(encodedUrl).validate().responseDecodable(of: InfoEdamamRequest.self) { (response) in
            completion(response.result)
        }
    }
    
    private (set) var recipes: [Recipe] = []
    
    func addRecipe(recipe: Recipe) {
        recipes.append(recipe)
    }
}
