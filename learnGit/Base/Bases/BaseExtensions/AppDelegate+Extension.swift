//
//  AppDelegateExtension.swift
//  VegaFintech
//
//  Created by Tu Dao on 5/31/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift



extension AppDelegate {
    // change root viewcontroller -------------------------
    func changeRootView(newRootView: UIViewController) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let nav = UINavigationController()
        nav.viewControllers = [newRootView]
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
    // setup first viewcontroller -----------------------
    func setupFirstViewController(_ vc: UIViewController){
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let nav = UINavigationController()
        nav.viewControllers = [vc]
        self.window!.rootViewController = nav
        self.window?.makeKeyAndVisible()
    }
    // setup iqkeyboard -------------------------
    class func setupIQKeyboard(){
        IQKeyboardManager.shared.enable = true   // kich hoat IQKeyboardManager
        IQKeyboardManager.shared.previousNextDisplayMode = .default // icon button previous/next/done tren toolbar
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true // placeholder trong textField's
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true  // tap ben ngoai ban phim se thoat khoi textField's
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Xong"  // text button Done
        IQKeyboardManager.shared.enableDebugging = true  //  enableDebugging = true
    }
    
    class func disableIQKeyboard(){
        //IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
    
    class func enableIQKeyboard(){
        //IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = true
    }
    
    // disable dark mode ---------------------
    func changeTheme(themeVal: String) {
      if #available(iOS 13.0, *) {
         switch themeVal {
         case "dark":
             window?.overrideUserInterfaceStyle = .dark
             break
         case "light":
             window?.overrideUserInterfaceStyle = .light
             break
         default:
             window?.overrideUserInterfaceStyle = .unspecified
         }
      }
    }
    // get current ViewController -------------------
    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}
