//
//  CoreDataStack.swift
//  RestaurantRater
//
//  Created by Xavier on 10/11/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import Foundation
import CoreData

struct CoreDataStack {

static let container: NSPersistentContainer = {
    
    let container = NSPersistentContainer(name: "name of file goes here")
    container.loadPersistentStores(completionHandler: { (_, error) in
        if let error = error{
            fatalError("Failed to Load Data from Persistent Store")
        }
    })
    return container
}()

static var context: NSManagedObjectContext {
    return container.viewContext
}
}
