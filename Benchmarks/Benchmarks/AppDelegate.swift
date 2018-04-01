//
//  AppDelegate.swift
//  Benchmarks
//
//  Created by William Duckworth on 01/04/2018.
//  Copyright © 2018 William Duckworth. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Benchmarks")
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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        preloadData()
        return true
    }
    
    func preloadData() {
        // Load the data file. For any reasons it can't be loaded, we just return
        guard let contentsOfURL = Bundle.main.url(forResource: "CompleteBenchMarkArchive-NoFBMs",withExtension: "csv") else {
            return
        }
        // Remove all the menu items before preloading
        removeData()
        // Parse the CSV file and import the data
        if let items = parseCSV(contentsOfURL: contentsOfURL, encoding: String.Encoding.utf8) {
            let context = persistentContainer.viewContext
            for item in items {
                let benchmarkItem = Benchmark(context: context)
                benchmarkItem.datum = item.datum
                benchmarkItem.easting = item.easting
                benchmarkItem.height = item.height
                benchmarkItem.height_above_ground = item.height_above_ground
                benchmarkItem.leveling_date = item.leveling_date
                benchmarkItem.mark_description = item.mark_description
                benchmarkItem.network = item.network
                benchmarkItem.ng_letters = item.ng_letters
                benchmarkItem.northing = item.northing
                benchmarkItem.order = item.order
                benchmarkItem.type_of_mark = item.type_of_mark
                benchmarkItem.verified_date = item.verified_date
                do {
                    try context.save()
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func removeData() {
        // Remove the existing items
        if let managedObjectContext = self.managedObjectContext {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Benchmarks")
            var e: NSError?
            let menuItems = managedObjectContext.executeFetchRequest(fetchRequest, error: &e) as! [MenuItem]
            
            if e != nil {
                print("Failed to retrieve record: \(e!.localizedDescription)")
                
            } else {
                
                for menuItem in menuItems {
                    managedObjectContext.deleteObject(menuItem)
                }
            }
        }
    }
}

