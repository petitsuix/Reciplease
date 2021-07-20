//
//  CoreDataTestCases.swift
//  RecipleaseTests
//
//  Created by Richardier on 13/07/2021.
//

import CoreData
import XCTest
@testable import Reciplease

class CoreDataTestCases: XCTestCase {
    var storageService: StorageService!
    var loadedRecipes: [Recipe] = []
    
    let recipe1 = FakeResponseData.recipe.first!
    let recipe2 = FakeResponseData.recipe[1]
    let recipe3 = FakeResponseData.recipe[2]
    
    override func setUp() {
        super.setUp()
        loadedRecipes = [recipe1, recipe2, recipe3]
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        persistentStoreDescription.shouldAddStoreAsynchronously = true
        
        let persistentContainer = NSPersistentContainer(name: "Reciplease",
                                                        managedObjectModel: managedObjectModel)
        persistentContainer.persistentStoreDescriptions = [persistentStoreDescription]
        persistentContainer.loadPersistentStores { description, error in
            precondition(description.type == NSInMemoryStoreType, "Store description is not of type NSInMemoryStoreType")
            if let error = error as NSError? {
                fatalError("Persistent container creation failed : \(error.userInfo)")
            }
        }
        storageService = StorageService(persistentContainer: persistentContainer)
    }
    
    override func tearDown() {
        storageService = nil
        loadedRecipes = []
        super.tearDown()
    }
    
    func testRecipeLoading() {
        var loadedRecipes: [Recipe] = []
        
        let recipe = FakeResponseData.recipe.first!
        
        do {
            try storageService.saveRecipe(recipe)
        } catch {
            XCTFail("error saving \(error.localizedDescription)")
        }
        
        do {
            loadedRecipes = try storageService.loadRecipes()
        } catch {
            XCTFail("error saving \(error.localizedDescription)")
        }
        XCTAssertFalse(loadedRecipes.isEmpty)
    }
    
    
    //    func testRecipeLoadingShouldFail() {
    //        var loadedRecipes: [Recipe] = []
    //
    //        let recipe = FakeResponseData.recipe.first!
    //        storageService.viewContext = FakeResponseData.viewContext!
    //
    //        do {
    //            try storageService.saveRecipe(recipe)
    //        } catch {
    //            XCTFail("error saving \(error.localizedDescription)")
    //        }
    //        XCTAssertThrowsError(try storageService.saveRecipe(recipe))
    //    }
    //
    
    func testDeleteRecipe() {
        for recipe in loadedRecipes {
            do {
                try storageService.saveRecipe(recipe)
            } catch {
                XCTFail("error saving \(error.localizedDescription)")
            }
            
            do {
                try storageService.deleteRecipe(recipe)
            } catch {
                XCTFail("error deleting \(error.localizedDescription)")
            }
            
            do {
                loadedRecipes = try storageService.loadRecipes()
            } catch {
                XCTFail("error loading \(error.localizedDescription)")
            }
        } 
        XCTAssertTrue(loadedRecipes.isEmpty)
        XCTAssert(loadedRecipes.count == 0)
    }
}
