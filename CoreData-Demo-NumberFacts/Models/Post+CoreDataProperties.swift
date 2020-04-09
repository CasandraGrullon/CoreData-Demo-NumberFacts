//
//  Post+CoreDataProperties.swift
//  CoreData-Demo-NumberFacts
//
//  Created by casandra grullon on 4/9/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var number: Double
    @NSManaged public var title: String?
    @NSManaged public var location: String?
    @NSManaged public var user: User?

}
