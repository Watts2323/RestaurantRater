//
//  Restaurant+Convenience.swift
//  RestaurantRater
//
//  Created by Xavier on 10/11/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import Foundation
import CoreData

extension Restaurant {
    
    convenience init(name: String, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        self.name = name
    }
}
