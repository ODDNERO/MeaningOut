//
//  SceneDelegate.swift
//  MeaningOut
//
//  Created by NERO on 6/13/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let isUser = UserDefaults.standard.bool(forKey: "isUser")
        
        switch isUser {
        case true:
            let mainVC = TabBarController()
            self.window?.rootViewController = mainVC
        case false:
            let onbordingVC = UINavigationController(rootViewController: OnbordingViewController())
            self.window?.rootViewController = onbordingVC
        }
        self.window?.makeKeyAndVisible()
    }
}

