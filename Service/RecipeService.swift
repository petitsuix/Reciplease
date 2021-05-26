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
    
    func fetchData(ingredients: String, completion: @escaping (Result<InfoEdamamRequest, AFError>) -> Void) {
        let url = "\(baseUrl)app_id=\(AppId.appId)&app_key=\(ApiKey.edamamKey)&q=\(ingredients)"
        AF.request(url).response { response in
            debugPrint(response)
            guard let data = response.data else { return }
            do {
                let decodedData = try JSONDecoder().decode(InfoEdamamRequest.self, from: data)
                print(decodedData)
            } catch let error {
                print(error)
            }
        }
        
        Session.default.request(url).validate().responseDecodable(of: InfoEdamamRequest.self) { (response) in
            completion(response.result)
        }
    }
}
