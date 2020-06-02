//
//  AppDelegate.swift
//  HYM3u8
//
//  Created by 刘东旭 on 2020/5/5.
//  Copyright © 2020 刘东旭. All rights reserved.
//

import UIKit
import AVKit
//import FLEX

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        AVPlayerViewController.registerHook(originalSelector: #selector(AVPlayerViewController.viewDidLoad), swizzledSelector: Selector(("myViewDidLoad")))
//        UIView.registerHook(originalSelector: #selector(UIView.addSubview(_:)), swizzledSelector: Selector(("myaddSubview:")))
//        FLEXManager.shared.showExplorer()
        return true
    }



}

