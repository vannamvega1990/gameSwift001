//
//  TestViewController1.swift
//  learnGit
//
//  Created by tran dinh thong on 8/15/21.
//

import UIKit

class TestViewController1: UIViewController {
    
    init() {
        super.init(nibName: "TestViewController1", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let appDelegate  = UIApplication.shared.delegate as! AppDelegate
    
    
    func pop(transitionType type: CATransitionType = .fade, duration: CFTimeInterval = 0.3) {
        
            self.addTransition(transitionType: type, duration: duration)
            //self.popViewController(animated: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.navigationController?.popViewController(animated: false)
        }
        //
        }
    
    private func addTransition(transitionType type: CATransitionType = .fade, duration: CFTimeInterval = 0.3) {
//           let transition = CATransition()
//           transition.duration = duration
//           transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//           transition.type = type
//
//           self.view.layer.add(transition, forKey: nil)
        
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude // repeat vo cung
        self.view.layer.add(rotation, forKey: "rotationAnimation")
        //self.layer.add(rotation, forKey: "rotationAnimation")
       }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
     
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            //self.customPop(typeAnimation: .fromTop)
            //self.pop()
            self.pop()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let window = UIApplication.shared.windows.first as UIWindow? {
            window.backgroundColor = UIColor.yellow
        }
        view.backgroundColor = UIColor.white
    }

}
