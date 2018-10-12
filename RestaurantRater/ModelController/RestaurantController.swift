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
    
    
    //Mark: - Crud
    
    
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
