//
//  MemoryCard+CoreDataProperties.swift
//  StarWars
//
//  Created by Mariano Manuel on 6/2/21.
//
//

import Foundation
import CoreData


extension MemoryCard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MemoryCard> {
        return NSFetchRequest<MemoryCard>(entityName: "MemoryCard")
    }

    @NSManaged public var date: String?
    @NSManaged public var id: Int16
    @NSManaged public var image: String?
    @NSManaged public var location: String?
    @NSManaged public var overview: String?
    @NSManaged public var title: String?
    @NSManaged public var imageData: Data?

}

extension MemoryCard : Identifiable {

}
