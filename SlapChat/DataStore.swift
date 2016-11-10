//
//  DataStore.swift
//  SlapChat
//
//  Created by Ian Rahman on 7/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import CoreData

class DataStore {
    
    var recipients:[Recipient] = []
    var messages:[Message] = []
    
    static let sharedInstance = DataStore()
    
    private init() {}
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "SlapChat")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Core Data Fetching support
    
    func fetchData() {
        let context = persistentContainer.viewContext
        let recipientRequest: NSFetchRequest<Recipient> = Recipient.fetchRequest()
        
        do {
            self.recipients = try context.fetch(recipientRequest)
        } catch let error {
            print("Error fetching data: \(error)")
            recipients = []
        }
        
        if recipients.count == 0 {
            generateTestData()
        }
    }
    
    // MARK: - Core Data generation of test data
    
    func generateTestData() {
        let context = persistentContainer.viewContext
      
        // define recipients
        let recipientOne: Recipient = NSEntityDescription.insertNewObject(forEntityName: "Recipient", into: context) as! Recipient
        recipientOne.email = "recipient1@company.com"
        recipientOne.name = "Bob"
        recipientOne.phoneNumber = "111-111-1111"
        recipientOne.twitterHandle = "recipient1"

        // define recipients
        let recipientTwo: Recipient = NSEntityDescription.insertNewObject(forEntityName: "Recipient", into: context) as! Recipient
        recipientTwo.email = "recipient2@company.com"
        recipientTwo.name = "Bill"
        recipientTwo.phoneNumber = "222-222-2222"
        recipientTwo.twitterHandle = "recipient2"
      
        // define messages
        let messageOne: Message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        messageOne.content = "Message 1"
        messageOne.createdAt = NSDate()
        recipientOne.addToMessages(messageOne)
      
      
        let messageTwo: Message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        messageTwo.content = "Message 2"
        messageTwo.createdAt = NSDate()
        recipientOne.addToMessages(messageTwo)
      
        let messageThree: Message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        messageThree.content = "Message 3"
        messageThree.createdAt = NSDate()
        recipientTwo.addToMessages(messageThree)

        saveContext()
        fetchData()
    }
    
}
