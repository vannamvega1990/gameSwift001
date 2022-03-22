////
////  TopiTabbarVC.swift
////  VegaFintech
////
////  Created by THONG TRAN on 15/10/2021.
////  Copyright © 2021 Vega. All rights reserved.
////
//
//
//import UIKit
//
////var TPTabBarViewControllerShared: BaseTabbarController? = nil
//
//class TopiTabbarVC: BaseTabbarController {
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        TPTabBarViewControllerShared = self
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        hiddenNavigation(isHidden: true)
//        
//        stateLogin = .Logined
//        
//        //custom tab bar
//        self.tabBar.barTintColor = AppColors.neutralBorder
//        self.tabBar.backgroundColor = AppColors.neutralBorder
//        self.tabBar.tintColor = AppColors.primary
//        self.tabBar.isTranslucent = false
//        addLine(height: 0.3, color: UIColor.init(hexString: "3E4258").withAlphaComponent(0.8))
//    }
//    
//    init() {
//        super.init(nibName: nil, bundle: nil)
//        let vc1 = TPHomeViewController.loadFromNib()
//        vc1.tabBarItem.title = "Trang chủ"
//        vc1.tabBarItem.image = UIImage.init(named: "ic_home")?.withRenderingMode(.alwaysOriginal)
//        vc1.tabBarItem.selectedImage = UIImage.init(named: "ic_home_selected")?.withRenderingMode(.alwaysOriginal)
//        
//        let vc2 = TPInvestmentProductVC.loadFromNib()
//        vc2.hideBack = true
//        vc2.tabBarItem.title = "Tài sản đầu tư"
//        vc2.tabBarItem.image = UIImage.init(named: "ic_asset")?.withRenderingMode(.alwaysOriginal)
//        vc2.tabBarItem.selectedImage = UIImage.init(named: "ic_asset_selected")?.withRenderingMode(.alwaysOriginal)
//        
//        let vc3 = FinanceVC.loadFromNib()
//        vc3.tabBarItem.title = "Tài chính"
//        vc3.tabBarItem.image = UIImage.init(named: "ic_finance")?.withRenderingMode(.alwaysOriginal)
//        vc3.tabBarItem.selectedImage = UIImage.init(named: "ic_finance_selected")?.withRenderingMode(.alwaysOriginal)
//        
//        let vc4 = TPAccountViewController()
//        vc4.tabBarItem.title = "Tài khoản"
//        vc4.tabBarItem.image = UIImage.init(named: "ic_profile")?.withRenderingMode(.alwaysOriginal)
//        vc4.tabBarItem.selectedImage = UIImage.init(named: "ic_profile_selected")?.withRenderingMode(.alwaysOriginal)
//
//        viewControllers = [vc1,vc2,vc3, vc4]
//
//        let selectedColor   = UIColor(red: 246.0/255.0, green: 155.0/255.0, blue: 13.0/255.0, alpha: 1.0)
//        let unselectedColor = UIColor(rgb: 0x919191, alpha: 1)
//
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .normal)
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        
//    }
//}
//
