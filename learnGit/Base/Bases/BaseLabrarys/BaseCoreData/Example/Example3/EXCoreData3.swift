//
//  EXCoreData3.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/24/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit
import CoreData

import UIKit

class EXCoreData3ViewController: BaseViewControllers {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        EXCoreData3.saveObject()
        EXCoreData3.saveObject()
        EXCoreData3.saveObject()
        
        let data = EXCoreData3.fetchObject()
    }
    
}

class EXCoreData3 {
    //MARK: - Video Part 1
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    class func fetchObject() -> [HocSinh]? {
        let context = getContext()
        var user:[HocSinh]? = nil
        do {
            user = try context.fetch(HocSinh.fetchRequest())
            return user
        }catch {
            return user
        }
    }
    class func saveObject() -> Bool{
        let context = getContext()
        let entity1 = NSEntityDescription.entity(forEntityName: "Persion", in: context)
        let manageObject1 = NSManagedObject(entity: entity1!, insertInto: context)
        manageObject1.setValue(165, forKey: "chieuCao")
        manageObject1.setValue("van nam", forKey: "name")
        
        let entity = NSEntityDescription.entity(forEntityName: "HocSinh", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        
        manageObject.setValue(6, forKey: "lop")
        manageObject.setValue(manageObject1, forKey: "linkPersion")
        do {
            try context.save()
            return true
        }catch {
            return false
        }
    }
    
}
