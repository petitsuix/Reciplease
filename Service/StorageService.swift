//
//  CoreDataService.swift
//  Reciplease
//
//  Created by Richardier on 07/06/2021.
//

import CoreData

class StorageService {
    
    let viewContext: NSManagedObjectContext

    init(persistentContainer: NSPersistentContainer = AppDelegate.persistentContainer) {
        // passer un persistentContainer par défaut
        self.viewContext = persistentContainer.viewContext
    }

    
    
    func loadRecipes() throws -> [Recipe] {
//     requete coreData, retourne objet recipeEntity converti en recipe dès que c'est loadé
        let fetchRequest: NSFetchRequest<RecipesEntity> = RecipesEntity.fetchRequest()
        let recipeEntities: [RecipesEntity]

        do {
            recipeEntities = try viewContext.fetch(fetchRequest)
        } catch {
            throw error
        }
        
        //convertir en boucle et implémenter le loadrecipes et favorites
        
//        for recipes in recipeEntities {
//        }
        
        let recipes = recipeEntities.map { (recipeEntity) -> Recipe in
            return Recipe(from: recipeEntity)
        }
        return recipes
     }
    
    func saveRecipe(_ recipe: Recipe) throws {
        let recipeEntity = RecipesEntity(context: viewContext)
        recipeEntity.name = recipe.name
        recipeEntity.imageUrl = recipe.imageUrl
        recipeEntity.ingredients = recipe.ingredients.joined(separator: ", ")
        recipeEntity.totalTime = recipe.totalTime ?? 15 
        recipeEntity.numberOfGuests = recipe.numberOfGuests
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                // Show some error here
//                print(error)
                throw error
            }
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
                viewContext.delete(recipeEntity) // save une fois que c'est supprimé
            }
        } catch {
            throw error
        }
        
        // utiliser le title de la recette pour l'identifier
//        let recipeEntity = RecipesEntity(context: viewContext)
//        if recipe.name == recipeEntity.name {
            //trouver comment remove la recipe
        // }
    }
}
