//
//  fakeResponseData.swift
//  RecipleaseTests
//
//  Created by Richardier on 06/07/2021.
//
import CoreData
import Foundation
@testable import Reciplease

final class FakeResponseData {
    
    class FakeError: Error {}
    static let error = FakeError()
    
    static let viewContext: NSManagedObjectContext? = nil
    
    static var recipe: [Recipe] {
        let recipeInfo = try! JSONDecoder().decode(InfoRecipe.self, from: recipeData)
        return recipeInfo.recipes
    }
    
    static var recipeData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Edamam", withExtension: "json")
        return try! Data(contentsOf: url!)
    }
    static let incorrectData = "erreur".data(using: .utf8)!
}
