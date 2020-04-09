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
    @discardableResult // silences the warnings if returned value is not used
    public func deleteUser(_ user: User) -> Bool {
        var wasDeleted = false
        context.delete(user)
        do {
            try context.save()
            wasDeleted = true
        } catch {
            print("failed to delete user: \(error.localizedDescription)")
        }
        return wasDeleted
    }
    
    public func createPost(for user: User, number: Double, title: String) -> Post {
        let post = Post(entity: Post.entity(), insertInto: context)
        post.title = title
        post.number = number
        post.user = user
        
        do {
            try context.save()
        } catch {
            print("error creating post: \(error.localizedDescription)")
        }
        return post
    }
    public func fetchPosts() -> [Post] {
        do {
            posts = try context.fetch(Post.fetchRequest())
        } catch {
            print("error fetching posts: \(error.localizedDescription)")
        }
        return posts
    }
    @discardableResult
    public func deletePost(_ post: Post) -> Bool {
        var wasDeleted = false
        context.delete(post)
        
        //save changes
        do {
            try context.save()
            wasDeleted = true
        } catch {
            print("failed to delete post: \(error.localizedDescription)")
        }
        return wasDeleted
    }
    
}
