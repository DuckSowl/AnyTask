//
//  ProjectMO+CoreDataProperties.swift
//  AnyTask
//
//  Created by Anton Tolstov on 08.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//
//

import Foundation
import CoreData


extension ProjectMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProjectMO> {
        return NSFetchRequest<ProjectMO>(entityName: "Project")
    }

    @NSManaged public var id: Data
    @NSManaged public var title: String
    @NSManaged public var subproject: NSSet?
    @NSManaged public var superproject: ProjectMO?
    @NSManaged public var tasks: NSOrderedSet?

}

// MARK: Generated accessors for subproject
extension ProjectMO {

    @objc(addSubprojectObject:)
    @NSManaged public func addToSubproject(_ value: ProjectMO)

    @objc(removeSubprojectObject:)
    @NSManaged public func removeFromSubproject(_ value: ProjectMO)

    @objc(addSubproject:)
    @NSManaged public func addToSubproject(_ values: NSSet)

    @objc(removeSubproject:)
    @NSManaged public func removeFromSubproject(_ values: NSSet)

}

// MARK: Generated accessors for tasks
extension ProjectMO {

    @objc(insertObject:inTasksAtIndex:)
    @NSManaged public func insertIntoTasks(_ value: TaskMO, at idx: Int)

    @objc(removeObjectFromTasksAtIndex:)
    @NSManaged public func removeFromTasks(at idx: Int)

    @objc(insertTasks:atIndexes:)
    @NSManaged public func insertIntoTasks(_ values: [TaskMO], at indexes: NSIndexSet)

    @objc(removeTasksAtIndexes:)
    @NSManaged public func removeFromTasks(at indexes: NSIndexSet)

    @objc(replaceObjectInTasksAtIndex:withObject:)
    @NSManaged public func replaceTasks(at idx: Int, with value: TaskMO)

    @objc(replaceTasksAtIndexes:withTasks:)
    @NSManaged public func replaceTasks(at indexes: NSIndexSet, with values: [TaskMO])

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: TaskMO)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: TaskMO)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSOrderedSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSOrderedSet)

}
