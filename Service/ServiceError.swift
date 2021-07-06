//
//  ServiceError.swift
//  Reciplease
//
//  Created by Richardier on 06/07/2021.
//

import Foundation

enum ServiceError: Error {
    case invalidResponse
    case emptyData
    case invalidStatusCode
    case errorFromApi(String)
    case decodingError
    case invalidUrl
}

extension ServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "invalid response"
        case .emptyData:
            return "empty data"
        case .invalidStatusCode:
            return "invalid status code"
        case .errorFromApi(let error):
            return "request returns an error: \(error)"
        case .decodingError:
            return "couldn't decode data"
        case .invalidUrl:
            return "invalid URL"
        }
    }
}
