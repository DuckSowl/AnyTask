//
//  CoreDataManager.swift
//  AnyTask
//
//  Created by Anton Tolstov on 30.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager<ManagedObject, Object>: CoreDataManageable where
    ManagedObject: NSManagedObject,
    ManagedObject: IdentifiableObject,
    ManagedObject.IdentityType == Data
{
            
    // MARK: - Properties
    
    let context: NSManagedObjectContext
    var getContext: NSManagedObjectContext {
        context.automaticallyMergesChangesFromParent = true
        return context
    }
    let saveContext: () -> ()
    
    // MARK: - Initializers
    
    init?() {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        context = delegate.persistentContainer.viewContext
        saveContext = delegate.saveContext
    }
    
    // MARK: - Private Methods
    
    func fetchAll() -> [ManagedObject]? {
        let fetchRequest: NSFetchRequest = ManagedObject.fetchRequest()
        return try? getContext.fetch(fetchRequest) as? [ManagedObject]
    }

    func fetch(with id: UUID) -> ManagedObject? {
        guard let objects = fetchAll() else { return nil }
        return objects.first(where: { $0.id.unsafeUUID() == id })
    }
}
