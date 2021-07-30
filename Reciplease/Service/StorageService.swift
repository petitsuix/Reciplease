//
//  CoreDataService.swift
//  Reciplease
//
//  Created by Richardier on 07/06/2021.
//

import CoreData

class StorageService {
    
    // MARK: - Properties
    
    static let shared = StorageService()
    private var viewContext: NSManagedObjectContext
    
    // MARK: - Methods
    
    init(persistentContainer: NSPersistentContainer = AppDelegate.persistentContainer) {
        self.viewContext = persistentContainer.viewContext
    }
    
    func loadRecipes() throws -> [Recipe] {
        let fetchRequest: NSFetchRequest<RecipesEntity> = RecipesEntity.fetchRequest() // Retrieves a group of managed objects held in the persistent store
        let recipeEntities: [RecipesEntity]
        
        do { recipeEntities = try viewContext.fetch(fetchRequest) }
        catch { throw error }
        
        let recipes = recipeEntities.map { (recipeEntity) -> Recipe in
            return Recipe(from: recipeEntity) // Model's init(from recipeEntity) allows to return a valid Recipe based on managed object's values
        }
        return recipes
    }
    
    func saveRecipe(_ recipe: Recipe) throws {
        let recipeEntity = RecipesEntity(context: viewContext)
        recipeEntity.name = recipe.name
        recipeEntity.imageUrl = recipe.imageUrl
        recipeEntity.ingredients = try? JSONEncoder().encode(recipe.ingredients)
        recipeEntity.totalTime = recipe.totalTime
        recipeEntity.numberOfGuests = recipe.numberOfGuests
        recipeEntity.recipeUrl = recipe.recipeUrl
        if viewContext.hasChanges {
            do { try viewContext.save() }
            catch { throw error }
        }
    }
    
    func deleteRecipe(_ recipe: Recipe) throws {
        let fetchRequest: NSFetchRequest<RecipesEntity> = RecipesEntity.fetchRequest() // Instantiating NSFetchRequest to retrieve a group of managed objects held in the persistent store
        let predicate = NSPredicate(format: "name == %@", recipe.name) // Condition used to constrain the search
        fetchRequest.predicate = predicate
        let recipeEntities: [RecipesEntity]
        do {
            recipeEntities = try viewContext.fetch(fetchRequest)
            recipeEntities.forEach { (recipeEntity) in
                viewContext.delete(recipeEntity)
            }
            try viewContext.save() // Save when a recipe is deleted
        } catch { throw error }
    }
}
