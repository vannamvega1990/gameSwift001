//
//  ExampleIndicator2.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/5/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class ExampleIndicator2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        showIndicator()
//        showIndicator()
//        showIndicator()
        let dulieu = "123"
        print(dulieu.checkBigCharacter())
        print("123   \n\n\nbbb\nb".trimming())
        print("123   \n\n\nbbb\nb".trim())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.stopIndicator()
//            self.stopIndicator()
            Commons.showLoading(self.view)
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            self.stopIndicator()
//            self.stopIndicator()
            Commons.hideLoading(self.view)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    


}
