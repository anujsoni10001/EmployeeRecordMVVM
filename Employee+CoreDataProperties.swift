//
//  Employee+CoreDataProperties.swift
//  EmployeeRecord
//
//  Created by Anuj Soni on 03/05/22.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var email: String?
    @NSManaged public var gender: String?
    @NSManaged public var id: UUID?
    @NSManaged public var mobileno: String?
    @NSManaged public var name: String?
    @NSManaged public var type: String?
}

extension Employee : Identifiable {

}


