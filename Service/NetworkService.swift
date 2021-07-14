//
//  EdamamService.swift
//  Reciplease
//
//  Created by Richardier on 25/05/2021.
//

import Alamofire

class NetworkService {
    
    private let session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    let baseUrl = "https://api.edamam.com/search?"
    
    func fetchData(for ingredients: String, completion: @escaping (Result<InfoEdamamRequest, AFError>) -> Void) {
        let url = "\(baseUrl)app_id=\(AppId.appId)&app_key=\(ApiKey.edamamKey)&q=\(ingredients)&to=100"
        let encodedUrl = url.replacingOccurrences(of: " ", with: "+")
        print(encodedUrl)
        session.request(encodedUrl).validate().responseDecodable(of: InfoEdamamRequest.self) { (response) in
            completion(response.result)
        }
    }
}
