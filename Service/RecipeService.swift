//
//  EdamamService.swift
//  Reciplease
//
//  Created by Richardier on 25/05/2021.
//

import UIKit
import Alamofire

class RecipeService {
    
    let baseUrl = "https://api.edamam.com/search?"
    
    func searchRecipes(for ingredients: String, completion: @escaping (Result<InfoEdamamRequest, AFError>) -> Void) {
        let url = "\(baseUrl)app_id=\(AppId.appId)&app_key=\(ApiKey.edamamKey)&q=\(ingredients)"
        let encodedUrl = url.replacingOccurrences(of: " ", with: "+")
        Session.default.request(encodedUrl).validate().responseDecodable(of: InfoEdamamRequest.self) { (response) in
            completion(response.result)
        }
    }
}
