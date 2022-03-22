//
//  TPTabBarViewController.swift
//  VegaFintech
//
//  Created by Tu Dao on 7/8/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

var TPTabBarViewControllerShared: BaseTabbarController? = nil

class TPTabBarViewController: BaseTabbarController {
    
    fileprivate lazy var defaultTabBarHeight = { tabBar.frame.size.height }()
    
    @objc func xuly(){
        let vc = UIViewController()
        vc.view.backgroundColor = .green
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    deinit {
        // TPTabBarViewControllerShared = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        TPTabBarViewControllerShared = self
        print(TPCakeDefaults.shared.access_token)
        print(TPCakeDefaults.shared.device_token)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stateLogin = .Logined
        //tabBar.barTintColor = .red #FEC166, 100%
        //tabBar.tintColor = UIColor(rgb: 0xFEC166, alpha: 1)
        
        //custom tab bar
        self.tabBar.barTintColor = UIColor(red: 0.0/255.0, green: 102.0/255.0, blue: 153.0/255.0, alpha: 1)
        self.tabBar.tintColor = UIColor(red: 171.0/255.0, green: 203.0/255.0, blue: 61.0/255.0, alpha: 1)
       
        
        
        
        
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
        //view.addSubview(middleButton)
        
        //customShapeTabar()
        //setGradientForTabBar()
        addLine(height: 0.3, color: UIColor.white)
        setBackgroundForTabBar(color: UIColor(rgb: 0x21232C, alpha: 1))

    }
    
    
    
    override func viewWillLayoutSubviews() {
           super.viewWillLayoutSubviews()

    }
    
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        let vc1 = TPHomeViewController()
        vc1.view.backgroundColor = .white
        let vc2 = UIViewController()
        vc2.view.backgroundColor = .yellow
        let vc3 = UIViewController()
        vc3.view.backgroundColor = .green
        let vc4 = TPAccountViewController()
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
        
        
        
        self.tabBar.items?[0].title = "Trang chủ"
        self.tabBar.items?[1].title = "Tải sản đầu tư"
        self.tabBar.items?[2].title = "Tài chính"
        self.tabBar.items?[3].title = "Tài khoản"
        
        
        
//        let iconHome = Common.shared.resizeImage(image: UIImage(named: "ic_home"), targetSize: CGSize(width: 26, height: 26))
//        let iconAsset = Common.shared.resizeImage(image: UIImage(named: "ic_asset"), targetSize: CGSize(width: 26, height: 26))
//        let iconFinace = Common.shared.resizeImage(image: UIImage(named: "ic_finance"), targetSize: CGSize(width: 26, height: 26))
//        let iconProfile = Common.shared.resizeImage(image: UIImage(named: "ic_profile"), targetSize: CGSize(width: 26, height: 26))
//        self.tabBar.items?[0].image = iconHome
//        self.tabBar.items?[1].image = iconAsset
//        self.tabBar.items?[2].image = iconFinace
//        self.tabBar.items?[3].image = iconProfile
        
        //self.tabBar.items?[0].titlePositionAdjustment = UIOffset(horizontal: -15, vertical: 0)
        //self.tabBar.items?[1].titlePositionAdjustment = UIOffset(horizontal: -35, vertical: 0)
        //self.tabBar.items?[2].titlePositionAdjustment = UIOffset(horizontal: 35, vertical: 0)
        //self.tabBar.items?[3].titlePositionAdjustment = UIOffset(horizontal: 15, vertical: 0)
        
        //self.tabBar.items?[1].imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let normal: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: UIColor.red,
                      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11)]
        let disabled: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0x919191, alpha: 1),
                                                      NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 11)]
        let selected: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0xFEC166, alpha: 1),
                                                             NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 11)]
        for (key,item) in self.tabBar.items!.enumerated()
        {
//            //item.image = item.selectedImage!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
//
//            item.setTitleTextAttributes(normal, for:UIControl.State.normal)
//            item.setTitleTextAttributes(disabled, for:UIControl.State.disabled)
//            item.setTitleTextAttributes(selected, for:UIControl.State.selected)
//
//            switch key {
//            case 0:
//                item.selectedImage = iconHome.setTintColor(with: .white, isOpaque: false)
//                item.image = iconHome.setTintColor(with: .red, isOpaque: false)
//                break
//            case 1:
//                item.selectedImage = item.selectedImage?.setTintColor(with: .white, isOpaque: false)
//                item.image = item.image?.setTintColor(with: .white, isOpaque: false)
//                //item.selectedImage = iconAsset.setTintColor(with: .white, isOpaque: false)
//                //item.image = iconAsset.setTintColor(with: .green, isOpaque: false)
//                break
//            case 2:
//                item.selectedImage = iconFinace.setTintColor(with: .white, isOpaque: false)
//                item.image = iconFinace.setTintColor(with: .green, isOpaque: false)
//                break
//
//            default:
//                item.selectedImage = iconProfile.setTintColor(with: .white, isOpaque: false)
//                item.image = iconProfile.setTintColor(with: .green, isOpaque: false)
//                break
//            }
            
        }
        
        let arrayOfImageNameForSelectedState: [String] = ["ic_home_on_bgsd","ic_asset_on_bgsd","ic_final_on_bgsd","ic_profile_on_bgsd"]
        let arrayOfImageNameForUnselectedState = ["ic_home_off_bgsd","ic_asset_off_bgsd","ic_final_off_bgsd","ic_profile_off_bgsd"]
        if let count = self.tabBar.items?.count {
            for i in 0...(count-1) {
                let imageNameForSelectedState   = arrayOfImageNameForSelectedState[i]
                let imageNameForUnselectedState = arrayOfImageNameForUnselectedState[i]

                self.tabBar.items?[i].selectedImage = UIImage(named: imageNameForSelectedState)?.withRenderingMode(.alwaysOriginal)
                self.tabBar.items?[i].image = UIImage(named: imageNameForUnselectedState)?.withRenderingMode(.alwaysOriginal)
            }
        }

        let selectedColor   = UIColor(red: 246.0/255.0, green: 155.0/255.0, blue: 13.0/255.0, alpha: 1.0)
        let unselectedColor = UIColor(rgb: 0x919191, alpha: 1)
            //UIColor(red: 16.0/255.0, green: 224.0/255.0, blue: 223.0/255.0, alpha: 1.0)

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
        
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    
}

