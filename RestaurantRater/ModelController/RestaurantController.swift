//
//  RestaurantController.swift
//  RestaurantRater
//
//  Created by Xavier on 10/11/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import Foundation
import CoreData

class RestaurantController {
    
    static var sharedInstance = RestaurantController()
    
    //Source of truth
    var restaurants: [Restaurant] {
            // telling PSC to fetch all the things based off our instructions below
            try? fetchResultsController.performFetch()
            guard let restaurants = fetchResultsController.fetchedObjects else {return []}
            return restaurants
    }
    
    //Mark: - Crud
    
    let fetchResultsController: NSFetchedResultsController<Restaurant> = {
        //Fetch request
        let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        //How i want them sorted
       let sortDescriptor = NSSortDescriptor(key: "isGood", ascending: false)
        
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    
    //Create
    func addRestaurant(name: String) {
        //Created a new restaurante in the managed object context
        let _ = Restaurant(name: name)
        saveToPersistentStore()
    }
    
    func delete(restaurant: Restaurant) {
//        restaurant.managedObjectContext?.delete(restaurant)
        CoreDataStack.context.delete(restaurant)
    }
    
    // Mark: - Persistence - Core Data
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("There was an error saving to Core Data: \(error)")
        }
    }
    
    }
