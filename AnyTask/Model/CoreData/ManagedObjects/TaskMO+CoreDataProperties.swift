//
//  TaskMO+CoreDataProperties.swift
//  AnyTask
//
//  Created by Anton Tolstov on 08.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//
//

import Foundation
import CoreData


extension TaskMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskMO> {
        return NSFetchRequest<TaskMO>(entityName: "Task")
    }

    @NSManaged public var comment: String?
    @NSManaged public var completed: Bool
    @NSManaged public var deadline: Date?
    @NSManaged public var expectedTime: Int32
    @NSManaged public var id: Data
    @NSManaged public var spentTime: Int32
    @NSManaged public var title: String
    @NSManaged public var project: ProjectMO?

}
