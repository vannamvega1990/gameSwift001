//
//  BaseAnimation.swift
//  learnGit
//
//  Created by tran dinh thong on 8/16/21.
//

import UIKit


extension UIViewController {
    
    func pop(animation: CABasicAnimation?, duration: CFTimeInterval = 1) {
        var anim: CABasicAnimation? = animation
        if anim == nil {
            anim = CABasicAnimation(keyPath: "transform.rotation.z")
            anim!.toValue = NSNumber(value: Double.pi * 2)
            anim!.duration = 1
            anim!.isCumulative = true
            anim!.repeatCount = Float.greatestFiniteMagnitude // repeat vo cung
        }
        self.view.layer.add(anim!, forKey: "popAnim")
        //self.addTransition(transitionType: type, duration: duration)
        //self.popViewController(animated: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.navigationController?.popViewController(animated: false)
        }
        //
    }
    
    func customPush(toVC vc: UIViewController, type typeAnimation:CATransitionSubtype){
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = typeAnimation
        //transition.subtype = CATransitionSubtype.fromTop
        //transition.subtype = CATransitionSubtype.fromBottom
        //transition.subtype = CATransitionSubtype.fromLeft
        //transition.subtype = CATransitionSubtype.fromRight
        self.navigationController!.view.layer.add(transition, forKey: nil)
        //let writeView = UIViewController()
        // writeView.view.backgroundColor = .red
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func customPop(typeAnimation type :CATransitionSubtype){
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = type
        self.navigationController!.view.layer.add(transition, forKey: nil)
        self.navigationController?.popViewController(animated: false)
    }
}
