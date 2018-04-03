//
//  BenchmarkDataHandler.swift
//  Benchmarks
//
//  Created by William Duckworth on 02/04/2018.
//  Copyright © 2018 William Duckworth. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class BenchmarkDataHandler: NSObject {
    
    private class func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    
    class func saveBenchmark(NG_LETTERS: String, EASTING: String, NORTHING: String, HEIGHT: String, DATUM: String, NETWORK: String, ORDER: String, TYPE_OF_MARK: String, HEIGHT_ABOVE_GROUND: String, VERIFIED_DATE: String, LEVELING_DATE: String, DESCRIPTION: String) -> Bool {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Benchmarks", in: context)
        let managedObject = NSManagedObject(entity: entity!, insertInto: context)
        
        managedObject.setValue(NG_LETTERS, forKey: "ng_letters")
        managedObject.setValue(EASTING, forKey: "easting")
        managedObject.setValue(NORTHING, forKey: "northing")
        managedObject.setValue(HEIGHT, forKey: "height")
        managedObject.setValue(DATUM, forKey: "datum")
        managedObject.setValue(NETWORK, forKey: "network")
        managedObject.setValue(ORDER, forKey: "order")
        managedObject.setValue(TYPE_OF_MARK, forKey: "type_of_mark")
        managedObject.setValue(HEIGHT_ABOVE_GROUND, forKey: "hight_above_ground")
        managedObject.setValue(VERIFIED_DATE, forKey: "verified_date")
        managedObject.setValue(LEVELING_DATE, forKey: "leveling_date")
        managedObject.setValue(DESCRIPTION, forKey: "mark_description")
        
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
}
