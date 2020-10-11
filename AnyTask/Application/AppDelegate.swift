//
//  AppDelegate.swift
//  AnyTask
//
//  Created by Anton Tolstov on 29.06.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit
import CoreData
import Pin

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let contentViewModel = ContentViewModel() else { return false }
        window!.rootViewController = ContentView(contentViewModel)
        window?.makeKeyAndVisible()
        return true
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container: NSPersistentContainer
        if #available(iOS 13.0, *) {
            container = NSPersistentCloudKitContainer(name: "DataModel")
        } else {
            container = NSPersistentContainer(name: "DataModel")
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
