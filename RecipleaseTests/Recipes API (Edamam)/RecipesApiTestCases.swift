//
//  RecipesApi.swift
//  RecipleaseTests
//
//  Created by Richardier on 05/07/2021.
//

import XCTest

@testable import Reciplease
@testable import Alamofire

class RecipesApi: XCTestCase {

    // MARK: - Properties
    
    var session: Session!
    var networkService: NetworkService!
    
    // MARK: - setUp & tearDown Methods
    
    override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolMock.self]
        session = Session(configuration: configuration)
        networkService = NetworkService(session: session)
    }
    
    override func tearDownWithError() throws {
        UrlProtocolMock.data = nil
        UrlProtocolMock.error = nil
    }
    
    // MARK: - Tests
    
    func testGetRecipesShouldPostFailedCompletionIfError() throws {
        let expectation = XCTestExpectation(description: "get recipes") // Purpose is being able to wait for the request, operated asynchronously. Otherwise, the end of the test is read immediately without going through the completion.
        // Given :
        UrlProtocolMock.error = AFError.explicitlyCancelled
        // When :
        networkService.fetchData(for: "chicken") { (result) in
            guard case .failure(let error) = result else {
                XCTFail("Missing failure error")
                return
            }
            // Then :
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGetRecipesShouldWork() throws {
        let expectation = XCTestExpectation(description: "get recipes")
        // Given :
        UrlProtocolMock.data = FakeResponseData.recipeData
        // When :
        networkService.fetchData(for: "chicken") { (result) in
            // Then :
            guard case .success(let recipes) = result else {
                XCTFail("Missing success data")
                return
            }
            XCTAssertNotNil(recipes)
            let recipe = try! XCTUnwrap(recipes.recipes.first, "missing recipe")
            XCTAssertEqual(recipe.name, "The Crispy Egg")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
