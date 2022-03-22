//
//  CoreDataHandler.swift
//  coreDataApp
//
//  Created by Yash Patel on 24/10/17.
//  Copyright © 2017 Yash Patel. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler: NSObject {
    //MARK: - Video Part 1
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    
    class func saveObject(fileInfo: FileInfo) -> Bool {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "ThongtinFile", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        
        manageObject.setValue(fileInfo.nameFile, forKey: "nameFile")
        manageObject.setValue(fileInfo.typeFile, forKey: "typeFile")
        manageObject.setValue(fileInfo.dungluongFile, forKey: "dungluongFile")
        manageObject.setValue(fileInfo.diachiFile, forKey: "diachiFile")
        manageObject.setValue(fileInfo.dateFile, forKey: "dateFile")
        
        do {
            try context.save()
            return true
        }catch {
            return false
        }
    }
    
    class func fetchObject() -> [ThongtinFile]? {
        let context = getContext()
        var user:[ThongtinFile]? = nil
        do {
            user = try context.fetch(ThongtinFile.fetchRequest())
            return user
        }catch {
            return user
        }
    }
    
    //MARK: - Video Part 2
    class func deleteObject(file: ThongtinFile) -> Bool {
    
        let context = getContext()
        context.delete(file)
        
        do {
            try context.save()
            return true
        }catch {
            return false
        }
        
    }
    
    class func updateObject(index: Int, nameFile:String, diachiFile:String) -> Bool {
        
        let context = getContext()
        
        do {
            let results = self.filterData()
            if results?.count != 0 { // Atleast one was returned

                // In my case, I only updated the first item in results
                results![index].setValue(nameFile, forKey: "nameFile")
                results![index].setValue(diachiFile, forKey: "diachiFile")
//                manageObject.setValue(fileInfo.nameFile, forKey: "nameFile")
//                manageObject.setValue(fileInfo.typeFile, forKey: "typeFile")
//                manageObject.setValue(fileInfo.diachiFile, forKey: "diachiFile")
                
                
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
        let delete = NSBatchDeleteRequest(fetchRequest: ThongtinFile.fetchRequest())
        
        do {
            try context.execute(delete)
            return true
        }catch {
            return false
        }
    }
    
    //MARK: - Video Part 3
    class func filterData() -> [ThongtinFile]? {
        let context = getContext()
        let fetchRequest:NSFetchRequest<ThongtinFile> = ThongtinFile.fetchRequest()
        var user:[ThongtinFile]? = nil
        
        //let predicate = NSPredicate(format: "password contains[c] %@", "123")
        //fetchRequest.predicate = predicate
        
        do {
            user = try context.fetch(fetchRequest)
            return user
            
        }catch {
            return user
        }
        
    
    }
}








