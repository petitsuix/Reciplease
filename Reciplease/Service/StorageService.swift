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
        //     requete coreData, retourne objet recipeEntity converti en recipe dès que c'est loadé
        let fetchRequest: NSFetchRequest<RecipesEntity> = RecipesEntity.fetchRequest()
        let recipeEntities: [RecipesEntity]
        
        do { recipeEntities = try viewContext.fetch(fetchRequest) }
        catch { throw error }
        //convertir en boucle et implémenter le loadrecipes et favorites
        
        
        let recipes = recipeEntities.map { (recipeEntity) -> Recipe in
            return Recipe(from: recipeEntity)
        }
        return recipes
    }
    
    func saveRecipe(_ recipe: Recipe) throws {
        let recipeEntity = RecipesEntity(context: viewContext)
        recipeEntity.name = recipe.name
        recipeEntity.imageUrl = recipe.imageUrl
        recipeEntity.ingredients = try? JSONEncoder().encode(recipe.ingredients)
        recipeEntity.totalTime = recipe.preparationTime
        recipeEntity.numberOfGuests = recipe.numberOfGuests
        recipeEntity.recipeUrl = recipe.recipeUrl
        if viewContext.hasChanges {
            do { try viewContext.save() }
            catch { throw ServiceError.savingError }
        }
    }
    
    func deleteRecipe(_ recipe: Recipe) throws {
        let fetchRequest: NSFetchRequest<RecipesEntity> = RecipesEntity.fetchRequest()
        let predicate = NSPredicate(format: "name == %@", recipe.name)
        fetchRequest.predicate = predicate
        let recipeEntities: [RecipesEntity]
        
        do {
            recipeEntities = try viewContext.fetch(fetchRequest)
            recipeEntities.forEach { (recipeEntity) in
                viewContext.delete(recipeEntity)
            }
            // save une fois que c'est supprimé
            try viewContext.save()
        } catch { throw error } // print(error) // a mettre dans le viewcontroller pour savoir dans chaque contexte ce qui a fail}
    }
}