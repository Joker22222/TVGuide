//
//  ContextManager.swift
//  TVGuide
//
//  Created by Fernando on 21/5/2019.
//  Copyright © 2019 Fernando. All rights reserved.
//

import UIKit
import CoreData

protocol ContextManagerInterface : ContextManagerConfigurationInterface, ContextManagerMovieInterface, ContextManagerShowInterface {
    func getContext() -> NSManagedObjectContext
    func saveContext()
}

class ContextManager:ContextManagerInterface {
    private let datastore: NSPersistentContainer
    private let context: NSManagedObjectContext

    init() {
        datastore = NSPersistentContainer(name: "TVGuideModel")
        datastore.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = datastore.persistentStoreCoordinator

    }
    
    init(testSotreCoordinator: NSPersistentContainer, testContext:NSManagedObjectContext) {
        datastore = testSotreCoordinator
        context = testContext
    }
    
    func getContext()  -> NSManagedObjectContext {
        return context
    }
    
    func saveContext() {
        if context.hasChanges {
            DispatchQueue.main.async(execute: { [weak self] in
                do {
                    try self?.context.save()
                } catch let mocSaveError as NSError {
                    print("Master Managed Object Context error: \(mocSaveError.localizedDescription)")
                }
            })
        }
    }    
}
