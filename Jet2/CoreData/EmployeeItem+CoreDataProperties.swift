//
//  EmployeeItem+CoreDataProperties.swift
//  Jet2
//
//  Created by Nikhil1 Yawalkar on 01/03/20.
//  Copyright © 2020 niks. All rights reserved.
//
//

import Foundation
import CoreData


extension EmployeeItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmployeeItem> {
        return NSFetchRequest<EmployeeItem>(entityName: "EmployeeItem")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var profileUrl: String?
    @NSManaged public var age: String?
    @NSManaged public var salary: String?

}
