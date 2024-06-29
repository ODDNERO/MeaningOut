//
//  UIViewController+.swift
//  MeaningOut
//
//  Created by NERO on 6/16/24.
//

import UIKit
import SnapKit

extension UIViewController {
    func findAvatarImageIndex(_ inputImage: UIImage) -> Int? {
        for (index, image) in Meaning.Image.avatars.enumerated() {
            if image == inputImage {
                return index
            }
        }
        return nil
    }
    
    func settingNavigation(title: String, rightBarItem: UIBarButtonItem?) {
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = title
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationItem.rightBarButtonItem = rightBarItem
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() //underline
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    func removeNavigationBarUnderline() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    func showAlert(title: String, message: String, okText: String, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: okText, style: .destructive) { _ in completionHandler() }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func designateRootVC(_ VC: UIViewController) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let sceneDelegate = windowScene.delegate as? SceneDelegate else { return }
        
        if VC is UITabBarController {
            sceneDelegate.window?.rootViewController = VC
        } else {
            sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: VC)
        }
        sceneDelegate.window?.makeKeyAndVisible()
    }
}
