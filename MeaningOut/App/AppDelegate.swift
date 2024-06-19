//
//  AppDelegate.swift
//  MeaningOut
//
//  Created by NERO on 6/13/24.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        sleep(2)
        IQKeyboardManager.shared.enable = true
        return true
    }
}
