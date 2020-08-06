//
//  CoreDataManagable.swift
//  AnyTask
//
//  Created by Anton Tolstov on 30.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import CoreData

protocol CoreDataManageable {
    associatedtype ManagedObject: NSManagedObject
    
    var context: NSManagedObjectContext { get }
    var saveContext: () -> () { get }
    
    func fetchAll() -> [ManagedObject]?
    func fetch(with id: UUID) -> ManagedObject?
}
