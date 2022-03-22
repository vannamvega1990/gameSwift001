//
//  slideMenu.swift
//  test001
//
//  Created by THONG TRAN on 19/03/2022.
//

import UIKit

class slideMenu: UIViewController {
    var menuVC: UIViewController!
    var mainVC: UIViewController!
    var widthOfMenu:CGFloat = 96
    
    var bgView: UIView!
    var userInfo: [AnyHashable:Any]?
    
    init(mainVC: UIViewController,menuVC: UIViewController,widthOfMenu:CGFloat = 96) {
        super.init(nibName: nil, bundle: nil)
        self.mainVC = mainVC
        self.menuVC = menuVC
        self.widthOfMenu = widthOfMenu
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Storyboard are a pain")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(hideMenu(_:)),
                                               name: NSNotification.Name("hideMenu"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(openMenu),
                                               name: NSNotification.Name("openMenu"),
                                               object: nil)
        bgView = UIView()
        bgView.frame = view.bounds
        bgView.backgroundColor = .gray.withAlphaComponent(0.6)
    }
    
    @objc func hideMenu(_ notification: NSNotification){
        userInfo = notification.userInfo
        closeMenu()
    }
    
    @objc func openMenu(){
        bgView.isHidden = false
        menuVC.view.isHidden = false
        openMenu1()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addVC()
        addGerter()
    }
    
    func addGerter(){
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapHandle(sender:)))
        bgView.addGestureRecognizer(tap)
    }
    
    @objc func tapHandle(sender:UITapGestureRecognizer){
        closeMenu()
    }
    
    func openMenu1(){
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut]) {
            self.menuVC.view.frame.origin.x = 0
        } completion: { state in
            
        }
    }
    
    
    func closeMenu(){
        bgView.isHidden = true
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseIn]) {
            self.menuVC.view.frame.origin.x = -self.widthOfMenu
        } completion: { state in
            
        }
    }
    
    func addVC(){
        self.addChild(menuVC)
        self.addChild(mainVC)
        mainVC.view.frame = view.bounds
        menuVC.view.frame = CGRect(x: -widthOfMenu, y: 0, width: widthOfMenu, height: view.bounds.height)
        menuVC.view.isHidden = true
        self.view.addSubview(mainVC.view)
        mainVC.didMove(toParent: self)
        view.addSubview(bgView)
        bgView.isHidden = true
        self.view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
    }
    
}
