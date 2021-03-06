//
//  EdamamService.swift
//  Reciplease
//
//  Created by Richardier on 25/05/2021.
//

import Alamofire

class NetworkService {
    
    // MARK: - Properties
    private let session: Session
    private let baseUrl = "https://api.edamam.com/search?"
    
    // MARK: - Methods
    init(session: Session = .default) { // Session is .default here but value is changed for API tests
        self.session = session
    }
    
    func fetchData(for ingredients: String, completion: @escaping (Result<InfoRecipe, AFError>) -> Void) {
        let url = "\(baseUrl)app_id=\(AppId.appId)&app_key=\(ApiKey.edamamKey)&q=\(ingredients)&to=100"
        let encodedUrl = url.replacingOccurrences(of: " ", with: "+")
        print(encodedUrl)
        session.request(encodedUrl).validate().responseDecodable(of: InfoRecipe.self) { (response) in // creating a data request from the encoded url
            completion(response.result)
        }
    }
}
