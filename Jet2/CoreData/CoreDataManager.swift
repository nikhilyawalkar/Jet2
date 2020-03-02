//
//  CoreDataManager.swift
//  Jet2
//
//  Created by Nikhil1 Yawalkar on 29/02/20.
//  Copyright © 2020 niks. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager : NSObject{
    
    private override init() {
        super.init()
        applicationLibraryDirectory()
    }
    
    // Create a shared Instance
    static let _shared = CoreDataManager()
    
    // Shared Function
    class func shared() -> CoreDataManager{
        return _shared
    }
    
    
    // Get the location where the core data DB is stored
    
    private lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls[urls.count-1])
        return urls[urls.count-1]
    }()
    
    private func applicationLibraryDirectory() {
        print(applicationDocumentsDirectory)
        if let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
            print(url.absoluteString)
        }
    }
    
    
    // MARK: - Core Data stack

    // Get the managed Object Context
    lazy var managedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Jet2")
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
    
    func saveEmployeeDataToDatabase(dataForSaving : [Employee]){
        //Get all the ids present in DB
        let existedItemIds = getAllPresentIds()
        
        //filter out data with check on id present in DB or not
        _ = dataForSaving.filter{!existedItemIds.contains($0.id ?? "")}.map{createEmployeeEntity(from: $0)}
        self.saveContext()
    }
    
    private func createEmployeeEntity(from model : Employee) -> EmployeeItem{
        let employeeItem = EmployeeItem(context: self.managedObjectContext)
        employeeItem.id = model.id
        employeeItem.name = model.name
        employeeItem.age = model.age
        employeeItem.salary = model.salary
        employeeItem.profileUrl = model.profileUrl
        
        return employeeItem
    }
    
    func getEmployeeDataFromDB() -> [EmployeeItem] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EmployeeItem")
        
        do{
            let results = try self.managedObjectContext.fetch(fetchRequest) as! [EmployeeItem]
            return results
        } catch {
            print(error)
        }
        return []
    }
    
    private func getAllPresentIds()->[String]{
        return getEmployeeDataFromDB().map{$0.id ?? ""}
    }
}
