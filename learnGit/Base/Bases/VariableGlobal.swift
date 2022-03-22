//
//  VariableGlobal.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/9/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

var currentVC:UIViewController = UIViewController()
let sizeScreen = UIScreen.main.bounds
//let window1 = UIApplication.shared.keyWindow!
var window:UIWindow {
    return appDelegate.window!
}
var windowFix:UIWindow {
    return appDelegate.window!
}
var versionApp: String? {
    let version = Commons.shared.getVersionApp() ?? ""
    let build = Commons.shared.getBuildApp() ?? ""
    return version + "." + build
}

let deviceID = UIDevice.current.identifierForVendor?.uuidString
let curentYear = Int(dateGlobal.yearCurrent)!
let curentMonth = Int(dateGlobal.monthCurrent)!

let secondOnce = 1
let minuteOnce = 60 * secondOnce
let hourOnce = 60 * minuteOnce
let dayOnce = 24 * hourOnce
let weekOnce = 7 * dayOnce

struct NotificationCenterName {
    static let KEY_GOOGLE_LOGINED: String                      = "KEY_GOOGLE_LOGINED"
}

struct SocialObject {
    var idUser: String?
    var email: String?
    var fullName: String?
}
//let appDelegate  = UIApplication.shared.delegate as! AppDelegate
var appDelegate: AppDelegate{
    return UIApplication.shared.delegate as! AppDelegate
}
