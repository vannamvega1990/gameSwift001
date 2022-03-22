//
//  BaseFile.swift
//  VegaFintech
//
//  Created by tran dinh thong on 7/26/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class BaseFile: NSObject {
    // save file to local  ---------------------
    func saveImageToLocal() {
        let image = UIImage(named: "chandai.jpg")
        let jpegData = image!.jpegData(compressionQuality: 1)!
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("test.jpg")
        
        do {
            try jpegData.write(to: fileURL, options: .atomic)
            print("da luu photo thanh cong")
            print(fileURL)
            UserDefaults.standard.set(fileURL, forKey: "urlPhoto")
        } catch {
            print(error)
        }
    }
    // read File saved  ---------------------
    func readData() {
        guard let urlPhoto = UserDefaults.standard.object(forKey: "urlPhoto") as! String? else {
            return
        }
        let dbPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let path = dbPath + "/test.jpg"
        print("\n\n\n\n==========")
        print(urlPhoto)
        print(path)
        let img = UIImageView()
        do {
            let dl : Data = try Data(contentsOf: URL(fileURLWithPath: path))
            img.image = UIImage(data: dl)
        } catch {
            print("chua doc dc")
        }
    }
    
    func saveFileToLocal1() {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let destinationUrl = documentsUrl!.appendingPathComponent("appendingPath")
        var location: URL?
        let dataFromURL = try? Data(contentsOf: location!)
        try? dataFromURL?.write(to: destinationUrl, options: [.atomic])
        print(destinationUrl)
    }
    // check File Is Exist Or Not ---------------------
    func checkFileIsExistOrNot(){
        let fileManager = FileManager.default
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        let fileName:String? = "test"
        let appendingPath = fileName ?? "unknown"
        let pathComponent = url.appendingPathComponent(appendingPath)
        let filePath = pathComponent!.path
        fileManager.fileExists(atPath: filePath)
    }
}
