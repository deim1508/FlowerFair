//
//  AppDelegate.swift
//  FlowerFair
//
//  Created by babycougar on 2/17/20.
//  Copyright © 2020 babycougar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var flow: RootFlowController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        flow = RootFlowController(window: window)
        flow?.start()
        
        return true
    }
}

