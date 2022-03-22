//
//  EXFireBaseViewController.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/10/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit
import FirebaseDatabase

class EXFireBaseViewController: BaseViewControllers {

    var baseFireBase = BaseFireBase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        

        //ref = Database.database().reference()
        //baseFireBase.writeTest()
        
        //baseFireBase.writeDictionaryWithComplete()
        //baseFireBase.writeTest1()
        //baseFireBase.writeTest1()
        //baseFireBase.readDataOnce()
        baseFireBase.readDataObserver()
        //baseFireBase.uploadFileFromMemory()
        Commons.showLoading(view)
        baseFireBase.uploadMedia { (url) in
            Commons.hideLoading(self.view)
            print(url)
        }
        //baseFireBase.setUsersPhotoURL(withImage: UIImage(named: "dog-0.jpg")!, andFileName: "dog1")
    }
   
}


