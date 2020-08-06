//
//  Project(MO)+.swift
//  AnyTask
//
//  Created by Anton Tolstov on 06.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

// MARK: Project Extensions

extension Project: IdentifiableObject { }

extension Project: ManagedObjectInitializable {
    init(managedObject projectMO: ProjectMO) {
        id = projectMO.id!.unsafeUUID()
        name = projectMO.title!
    }
}

// MARK: ProjectMO Extensions

extension ProjectMO: IdentifiableObject { }

