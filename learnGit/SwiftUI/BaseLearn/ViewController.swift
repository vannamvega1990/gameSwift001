//
//  ViewController.swift
//  learnGit
//
//  Created by tran dinh thong on 7/24/21.
//

import UIKit
import SwiftUI

@available(iOS 13.0, *)
class ViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            let transition = CATransition()
//            transition.duration = 0.5
//            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//            transition.type = CATransitionType.push
//            //transition.subtype = CATransitionSubtype.fromTop
//            //transition.subtype = CATransitionSubtype.fromBottom
//            //transition.subtype = CATransitionSubtype.fromLeft
//            transition.subtype = CATransitionSubtype.fromRight
//            self.navigationController!.view.layer.add(transition, forKey: nil)
//            let writeView = UIViewController()
//            writeView.view.backgroundColor = .red
//            self.navigationController?.pushViewController(writeView, animated: false)
            
            //self.customPush(toVC: TestViewController1(), type: .fromTop)
            
            //var swiftUIView = ContentView() // swiftUIView is View
            //let swiftUIView = ContentView1()
            //let viewCtrl = UIHostingController(rootView: swiftUIView)
            let viewCtrl = UIHostingController(rootView: PushToViewController().environmentObject(Model()))
            
            //let vc = UIHostingController(rootView: ContentView)
            self.navigationController?.pushViewController(viewCtrl, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("123---")
        view.backgroundColor = .red
    }
    
    


}


