//
//  TabBarViewController.swift
//  FinTech
//
//  Created by Tu Dao on 5/12/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit


class TabBarViewController: BaseTabbarController {
    
    fileprivate lazy var defaultTabBarHeight = { tabBar.frame.size.height }()
    
    @objc func xuly(){
        let vc = UIViewController()
        vc.view.backgroundColor = .green
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        hiddenNavigation(isHidden: true)
        let middleButton = UIButton()
        middleButton.addTarget(self, action: #selector(xuly), for: .touchUpInside)
        middleButton.setImage(UIImage(named: "ic_video"), for: .normal)
        middleButton.frame.size = CGSize(width: 80, height: 80)
        middleButton.backgroundColor = .orange
        middleButton.layer.cornerRadius = 40
        middleButton.layer.masksToBounds = true
        let heightTabbar = self.tabBarController?.tabBar.frame.height ?? 49.0
        let (_, bottomsafeArea) = getHeightOfSafeArea()
        middleButton.center = CGPoint(x: UIScreen.main.bounds.width / 2, y:
        UIScreen.main.bounds.height - heightTabbar - bottomsafeArea)
        view.addSubview(middleButton)
        
        //middleButton.center = CGPoint(x: tabBar.frame.width / 2, y: 10)
        //tabBar.addSubview(middleButton)
        
//        let tabBarHeight = self.tabBar.frame.height + 35
//        var tabFrame = self.tabBar.frame
//        guard let window = UIApplication.shared.keyWindow else {return}
//        tabFrame.size.height = tabBarHeight + window.safeAreaInsets.bottom
//        tabFrame.origin.y = sizeScreen.height - tabFrame.size.height
//        self.tabBar.frame = tabFrame
        
        customShapeTabar()
        setGradientForTabBar()
        
        
//        let shape = CAShapeLayer()
//        //let path = UIBezierPath(roundedRect: self.tabBar.bounds, cornerRadius: 56)
//        let path = UIBezierPath(roundedRect: self.tabBar.bounds, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 56, height: 8))
//        shape.path = path.cgPath
//        self.tabBar.layer.mask = shape
//        tabBar.backgroundColor = .red
    }
    
    
    
    override func viewWillLayoutSubviews() {
           super.viewWillLayoutSubviews()
        //self.tabBar.sizeThatFits(CGSize(width: sizeScreen.width, height: 87))
        //self.tabBar.layer.cornerRadius = 56
//        let newTabBarHeight = defaultTabBarHeight + 56.0
//
//                var newFrame = tabBar.frame
//                newFrame.size.height = newTabBarHeight
//                newFrame.origin.y = view.frame.size.height - newTabBarHeight
//
//                tabBar.frame = newFrame
        //navigationController?.isNavigationBarHidden = true
    }
    
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        let vc1 = HomeViewController()
        vc1.view.backgroundColor = .white
        let vc2 = UIViewController()
        vc2.view.backgroundColor = .yellow
        let vc3 = UIViewController()
        vc3.view.backgroundColor = .green
        let vc4 = ProfileViewController()
        //vc4.view.backgroundColor = .orange
//        let navi1 = UINavigationController(rootViewController: vc1)
//        let navi2 = UINavigationController(rootViewController: vc2)
//        let navi3 = UINavigationController(rootViewController: vc3)
//        let navi4 = UINavigationController(rootViewController: vc4)
//        vc1.hiddenNavigation(isHidden: true)
//        vc2.hiddenNavigation(isHidden: true)
//        vc3.hiddenNavigation(isHidden: true)
//        vc4.hiddenNavigation(isHidden: true)
        viewControllers = [vc1,vc2,vc3, vc4]   //[navi1, navi2, navi3, navi4]
        
        
        
        self.tabBar.items?[0].title = "Ảnh/Video"
        self.tabBar.items?[1].title = "Cộng đồng"
        self.tabBar.items?[2].title = "Tin nhắn"
        self.tabBar.items?[3].title = "Cá nhân"
        
        
        
        let icon = Common.shared.resizeImage(image: UIImage(named: "ic_camera")!, targetSize: CGSize(width: 26, height: 26))
        self.tabBar.items?[0].image = icon
        self.tabBar.items?[1].image = icon
        self.tabBar.items?[2].image = icon
        self.tabBar.items?[3].image = icon
        
        self.tabBar.items?[0].titlePositionAdjustment = UIOffset(horizontal: -15, vertical: 0)
        self.tabBar.items?[1].titlePositionAdjustment = UIOffset(horizontal: -35, vertical: 0)
        self.tabBar.items?[2].titlePositionAdjustment = UIOffset(horizontal: 35, vertical: 0)
        self.tabBar.items?[3].titlePositionAdjustment = UIOffset(horizontal: 15, vertical: 0)
        //self.tabBar.items?[1].imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    
}
