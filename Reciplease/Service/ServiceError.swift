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
    case savingError
    case deletingError
    case loadingError
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
        case .savingError:
            return "error while trying to save data"
        case .deletingError:
            return "error while trying to reach and delete data"
        case .loadingError:
            return "error while trying to load data"
        }
    }
}
