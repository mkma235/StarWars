//
//  MemCard+CoreDataProperties.swift
//  StarWars
//
//  Created by Mariano Manuel on 5/26/21.
//
//

import Foundation
import CoreData


extension MemCard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MemCard> {
        return NSFetchRequest<MemCard>(entityName: "MemCard")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var image: String?
    @NSManaged public var date: String?
    @NSManaged public var title: String?
    @NSManaged public var location: String?
    @NSManaged public var overview: String?

}

extension MemCard : Identifiable {

}
