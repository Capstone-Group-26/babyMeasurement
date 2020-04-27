//
//  Measurement+CoreDataProperties.swift
//  
//
//  Created by user171419 on 4/26/20.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Measurement {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Measurement> {
        return NSFetchRequest<Measurement>(entityName: "Measurement")
    }

    @NSManaged public var date: Date?
    @NSManaged public var height: Double
    @NSManaged public var child: Child?

}
