//
//  EXBaseKeyChainViewController.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/13/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class EXBaseKeyChainViewController: BaseViewControllers {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let int: Int = 555111
        let data = Data(from: int)
        let status = BaseKeyChain.save(key: "MyNumber", data: data)
        print("status: ", status)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if let receivedData = BaseKeyChain.load(key: "MyNumber") {
                //let result = receivedData.to(type: Int.self)
                let result1 = receivedData.toString()
                print("result: ", result1)
            }
            //BaseKeyChain.clearAllKeychain()
        }
        
//        let pass: String = "xuantruong"
//        let data2 = Data(from: pass)
//        let status2 = BaseKeyChain.save(key: "pass", data: data2)
//        print("status2: ", status2)

        
    }
    
    func example(){ // chuẩn hơn ------------------
        let string_Data = BaseKeyChain.stringToDATA(string: "MANIAK")
        BaseKeyChain.save(key: "ZAHAL", data: string_Data)
        
        let RecievedDataStringAfterSave = BaseKeyChain.load(key: "ZAHAL")
        let NSDATAtoString = BaseKeyChain.DATAtoString(data: RecievedDataStringAfterSave!)
        print(NSDATAtoString)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundColor()
//        let pass: String = "xuantruong"
//        let data2 = Data(from: pass)
//        let status2 = BaseKeyChain.save(key: "pass", data: data2)
//        print("status2: ", status2)
        
        if let receivedData = BaseKeyChain.load(key: "pass") {
            //let result = receivedData.to(type: String.self)
            let result = receivedData.toString()
            print("result: ", result)
        }
        
        let status = BaseKeyChain.remove(serviceKey: "pass")
        print("status: ", status)
        
        if let receivedData = BaseKeyChain.load(key: "pass") {
            //let result = receivedData.to(type: String.self)
            let result = receivedData.toString()
            print("result: ", result)
        }
        
    }
    
}
