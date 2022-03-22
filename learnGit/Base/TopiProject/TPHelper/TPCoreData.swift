//
//  TPCoreData.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/23/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit
import CoreData

class TPCoreData {
    //MARK: - Video Part 1
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    class func saveTouchObject(value:Bool) -> Bool {
        
        if let filterData = TPCoreData.filterData() {
            return TPCoreData.updateObject(index: 0, isTouch1:value)
        }else{
            let context = getContext()
            let entity = NSEntityDescription.entity(forEntityName: "DataTouchUser", in: context)
            let manageObject = NSManagedObject(entity: entity!, insertInto: context)
            
            manageObject.setValue(mobileTemp, forKey: "mobile")
            manageObject.setValue(value, forKey: "isTouch")
            do {
                try context.save()
                return true
            }catch {
                return false
            }
        }
    }
    
    class func fetchObject() -> [DataTouchUser]? {
        let context = getContext()
        var user:[DataTouchUser]? = nil
        do {
            user = try context.fetch(DataTouchUser.fetchRequest())
            return user
        }catch {
            return user
        }
    }
    
    class func updateObject(index: Int, isTouch1:Bool) -> Bool {
        let context = getContext()
        do {
            let results = TPCoreData.filterData()
            if results?.count != 0 { // Atleast one was returned
                // In my case, I only updated the first item in results
                results![index].setValue(mobileTemp, forKey: "mobile")
                results![index].setValue(isTouch1, forKey: "isTouch")
            }
            
        } catch {
            print("Fetch Failed: \(error)")
            return false
        }
        do {
            try context.save()
            return true
           }
        catch {
            print("Saving Core Data Failed: \(error)")
            return false
        }
    }
    
    class func cleanDelete() -> Bool {
        let context = getContext()
        let delete = NSBatchDeleteRequest(fetchRequest: DataTouchUser.fetchRequest())
        
        do {
            try context.execute(delete)
            return true
        }catch {
            return false
        }
    }
    //MARK: - Video Part 3
    class func filterData() -> [DataTouchUser]? {
        let context = getContext()
        let fetchRequest:NSFetchRequest<DataTouchUser> = DataTouchUser.fetchRequest()
        var user:[DataTouchUser]? = nil
        
        let filter = mobileTemp
        let predicate = NSPredicate(format: "mobile = %@", filter)
        fetchRequest.predicate = predicate
        
        //let predicate = NSPredicate(format: "password contains[c] %@", mobileTemp)
        //fetchRequest.predicate = predicate
        
        do {
            user = try context.fetch(fetchRequest)
            return user
            
        }catch {
            return user
        }
    }
}
