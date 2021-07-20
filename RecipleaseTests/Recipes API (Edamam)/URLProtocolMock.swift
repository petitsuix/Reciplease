//
//  URLSessionFake.swift
//  RecipleaseTests
//
//  Created by Richardier on 06/07/2021.
//

import XCTest
import Foundation

class UrlProtocolMock: URLProtocol {
    
    static var error: Error?
    static var data: Data?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let error = UrlProtocolMock.error {
            client?.urlProtocol(self, didFailWithError: error)
            client?.urlProtocolDidFinishLoading(self)
            return
        }
        guard let data = UrlProtocolMock.data else {
            XCTFail("success data is missing")
            return
        }
        client?.urlProtocol(self, didLoad: data)
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
}
