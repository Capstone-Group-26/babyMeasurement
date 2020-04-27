//
//  Child+CoreDataProperties.swift
//  
//
//  Created by user171419 on 4/26/20.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Child {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Child> {
        return NSFetchRequest<Child>(entityName: "Child")
    }

    @NSManaged public var birthDate: Date?
    @NSManaged public var birthHeight: Double
    @NSManaged public var name: String?
    @NSManaged public var sex: String?
    @NSManaged public var measurements: NSOrderedSet?

}

// MARK: Generated accessors for measurements
extension Child {

    @objc(insertObject:inMeasurementsAtIndex:)
    @NSManaged public func insertIntoMeasurements(_ value: Measurement, at idx: Int)

    @objc(removeObjectFromMeasurementsAtIndex:)
    @NSManaged public func removeFromMeasurements(at idx: Int)

    @objc(insertMeasurements:atIndexes:)
    @NSManaged public func insertIntoMeasurements(_ values: [Measurement], at indexes: NSIndexSet)

    @objc(removeMeasurementsAtIndexes:)
    @NSManaged public func removeFromMeasurements(at indexes: NSIndexSet)

    @objc(replaceObjectInMeasurementsAtIndex:withObject:)
    @NSManaged public func replaceMeasurements(at idx: Int, with value: Measurement)

    @objc(replaceMeasurementsAtIndexes:withMeasurements:)
    @NSManaged public func replaceMeasurements(at indexes: NSIndexSet, with values: [Measurement])

    @objc(addMeasurementsObject:)
    @NSManaged public func addToMeasurements(_ value: Measurement)

    @objc(removeMeasurementsObject:)
    @NSManaged public func removeFromMeasurements(_ value: Measurement)

    @objc(addMeasurements:)
    @NSManaged public func addToMeasurements(_ values: NSOrderedSet)

    @objc(removeMeasurements:)
    @NSManaged public func removeFromMeasurements(_ values: NSOrderedSet)

}
