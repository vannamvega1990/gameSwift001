//
//  BaseFireBase.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/10/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseCore
import Firebase
import FirebaseStorage

class BaseFireBase {
    static let singleton = BaseFireBase()
    var ref: DatabaseReference!
    var storageRef: StorageReference!
    init() {
        ref = Database.database().reference()
        // Create a root reference
        let storage = Storage.storage()
        storageRef = storage.reference()
    }
    
    func writeWithComplete(){
        Commons.showLoading(currentVC.view)
        //ref.child("users").child(user.uid).setValue(["username": username]) {
        self.ref.child("users").child("id12").setValue(["username": "username12"]) {
          (error:Error?, ref:DatabaseReference) in
            Commons.hideLoading(currentVC.view)
          if let error = error {
            print("Data could not be saved: \(error).")
          } else {
            print("Data saved successfully!")
          }
        }
    }
    
    func writeDictionaryWithComplete(){
        Commons.showLoading(currentVC.view)
        //ref.child("users").child(user.uid).setValue(["username": username]) {
        self.ref.child("users").child("id12").setValue(["username": "username12",
                                                        "password": 123456]) {
          (error:Error?, ref:DatabaseReference) in
            Commons.hideLoading(currentVC.view)
          if let error = error {
            print("Data could not be saved: \(error).")
          } else {
            print("Data saved successfully!")
          }
        }
    }
    
    func writeArrayWithComplete(){
        Commons.showLoading(currentVC.view)
        //ref.child("users").child(user.uid).setValue(["username": username]) {
        self.ref.child("users").child("id12").setValue([["username": "username12",
                                                        "password": 123456],
                                                        ["username": "username16",
                                                         "password": 1234567890],]) {
          (error:Error?, ref:DatabaseReference) in
            Commons.hideLoading(currentVC.view)
          if let error = error {
            print("Data could not be saved: \(error).")
          } else {
            print("Data saved successfully!")
          }
        }
    }
    
    func writeTest(){
        //self.ref.child("users").child(user.uid).setValue(["username": username])
        //self.ref.child("users/\(user.uid)/username").setValue(username)
        
        self.ref.child("users").child("id12").setValue(["username": "username12"])
    }
    
    func writeTest1(){
        //self.ref.child("users").child(user.uid).setValue(["username": username])
        self.ref.child("users").childByAutoId().setValue(["username": "username123"])
    }
    
    func readTest1(){
//        refHandle = postRef.observe(DataEventType.value, with: { snapshot in
//          // ...
//        })
    }
    
    func readDataOnce(){
        //self.ref.child("users/\(user.uid)/username").getData { (error, snapshot) in
        
        self.ref.child("users/id12/username").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
            }
            else {
                print("No data available")
            }
        }
        
        self.ref.child("users").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
            }
            else {
                print("No data available")
            }
        }
    }
    
    func readDataOneAndObserver(){
        //ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { snapshot in
        ref.child("users").child("id12/0").observeSingleEvent(of: .value, with: { snapshot in
          // Get user value
          let value = snapshot.value as? NSDictionary
          let username = value?["username"] as? String ?? ""
            print(username)
          //let user = User(username: username)

          // ...
        }) { error in
          print(error.localizedDescription)
        }
    }
    
    func readDataObserver(){
        //ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { snapshot in
        ref.child("users").child("id12/0").observe(.value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let username = value?["username"] as? String ?? ""
              print(username)
            let pass = value?["password"] as? String ?? ""
              print(pass)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func setUsersPhotoURL(withImage: UIImage, andFileName: String) {
        guard let imageData = withImage.jpegData(compressionQuality: 0.5) else { return }
        let storageRef = Storage.storage().reference()
        //let thisUserPhotoStorageRef = storageRef.child("this users uid").child(andFileName)
        let thisUserPhotoStorageRef = Storage.storage().reference().child("fileName")

        let metadata = StorageMetadata()
        metadata.contentType = "png"
        _ = thisUserPhotoStorageRef.putData(imageData, metadata: metadata) { (metadata, error) in
            guard let metadata = metadata else {
                print("error while uploading")
                return
            }

            thisUserPhotoStorageRef.downloadURL { (url, error) in
                print(metadata.size) // Metadata contains file metadata such as size, content-type.
                thisUserPhotoStorageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        print("an error occured after uploading and then getting the URL")
                        return
                    }

                }
            }
        }
    }
    
    func uploadMedia(completion: @escaping (_ url: String?) -> Void) {
        //let storageRef = FIRStorage.storage().reference().child("myImage.png")
        let storageRef = self.storageRef.child("myImage.png")
        let img = UIImage(named: "dog-0.jpg")
        //if let uploadData = UIImagePNGRepresentation(self.myImageView.image!) {
        if let uploadData = img!.pngData() {
           let uploadTask =  storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print("error")
                    completion(nil)
                } else {
                    storageRef.downloadURL { (url, error) in
                        guard let downloadURL = url else {
                            // Uh-oh, an error occurred!
                            print("upload thanh cong- ko co url file")
                            completion(nil)
                            return
                        }
                        print("url sau upload: \(downloadURL)")
                        completion("\(downloadURL)")
                    }
                    //completion(metadata?.downloadURL()?.absoluteString)!)
                    // your uploaded photo url.
                }
            }
            
            // Add a progress observer to an upload task
//            let observer = uploadTask.observe(.progress) { snapshot in
//              // A progress event occured
//                print("-----------\(snapshot.progress!.completedUnitCount)")
//            }
            uploadTask.observe(.progress) { snapshot in
              // Upload reported progress
              let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
                / Double(snapshot.progress!.totalUnitCount)
                print("-----------\(percentComplete)")
            }

            uploadTask.observe(.success) { snapshot in
              // Upload completed successfully
                print("-----------Upload completed successfully")
            }
        }
    }
    
    func uploadFileFromMemory(){
        // Data in memory
        //let data = Data()
        let data = UIImage(named: "dog-0.jpg")!.convertToData()!
        // Create a reference to the file you want to upload
        let riversRef = storageRef.child("images/rivers.jpg")
        // Upload the file to the path "images/rivers.jpg"
        
        Commons.showLoading(currentVC.view)
        
        let uploadTask = riversRef.putData(data, metadata: nil) { (metadata, error) in
            
            Commons.hideLoading(currentVC.view)
            
          guard let metadata = metadata else {
            // Uh-oh, an error occurred!
            print("upload loi")
            return
          }
            print("upload thanh cong")
          // Metadata contains file metadata such as size, content-type.
          let size = metadata.size
            print("size of file : \(size)")
          // You can also access to download URL after upload.
          riversRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
              // Uh-oh, an error occurred!
                print("upload thanh cong- ko co url file")
              return
            }
            print("url sau upload: \(downloadURL)")
          }
        }
    }
}

