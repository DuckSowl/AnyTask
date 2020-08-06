//
//  DataManageable.swift
//  AnyTask
//
//  Created by Anton Tolstov on 13.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import Foundation

protocol DataManageable {
    associatedtype Object
    
    func add(_: Object)       // C
    func getAll() -> [Object] // R
    func update(_: Object)    // U
    func delete(_: Object)    // D
}

extension DataManageable where
    Self: CoreDataManageable,
    Object: IdentifiableObject,
    Object.IdentityType == UUID,
    Object: ManagedObjectInitializable,
    Object.ManagedObject == Self.ManagedObject
{
    
    func getAll() -> [Object] {
        let objects = fetchAll() ?? []
        return objects.map { Object(managedObject: $0) }
    }
    
    func delete(_ object: Object) {
        guard let object = fetch(with: object.id) else { return }
        context.delete(object)
        
        saveContext()
    }
}
