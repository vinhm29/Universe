//
//  Persistence.swift
//  Universe
//
//  Created by Vincenzo Tipacti Moran on 24/02/22.
//

import Foundation
import CoreData

class PersistenceController {
    
    let persistentContainer: NSPersistentContainer
    static let shared: PersistenceController = PersistenceController()
    
    private init() {
        
        persistentContainer = NSPersistentContainer(name: "Universe")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
        
    }
    
}
