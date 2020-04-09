//
//  CoreDataManager.swift
//  CoreData-Demo-NumberFacts
//
//  Created by casandra grullon on 4/9/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    
    // implement singleton
    static let shared = CoreDataManager()
    
    private init() {}
    
    private var users = [User]() // User is a NSManagedObject
    
    private var posts = [Post]() // Post is a NSManagedObject
    
    //need access to the persistence container in the app delegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //viewContext is of type NSManagedObjectContext -> the box that holds all the managed objects
    
    //CRUD methods (create, read, update, delete)
    public func createUser(name: String, dob: Date) -> User {
        //create changes
        let user = User(entity: User.entity(), insertInto: context)
        user.name = name
        user.dob = dob
        
        //save changes to the NSManagedObjectContext
        //similar to saving to file manager
        do {
            try context.save() //save object to the box
        } catch {
            print("error saving user: \(error.localizedDescription)")
        }
        return user
    }
    
    public func fetchUsers() -> [User] {
        do {
            users = try context.fetch(User.fetchRequest()) //gets all the objects from Core Data
            //we can use NSPredicate to sort and filter Core Data objects when fetching
        } catch {
            print("error fetching users: \(error.localizedDescription)")
        }
        return users
    }
    
    public func updateUser() {
        
    }
    
    public func deleteUser() {
        
    }
    
}
