//
//  UIViewController+.swift
//  MeaningOut
//
//  Created by NERO on 6/16/24.
//

import UIKit

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
        navigationController?.navigationBar.shadowImage = nil
        navigationItem.title = title
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black
        ]
        navigationController?.navigationItem.rightBarButtonItem = rightBarItem
    }
    
    func alertDeleteAccount(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .destructive) { _ in
            self.designateRootVC(OnbordingViewController())
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func designateRootVC(_ VC: UIViewController) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let sceneDelegate = windowScene.delegate as? SceneDelegate else { return }
        
        let rootViewController = UINavigationController(rootViewController: VC)
        sceneDelegate.window?.rootViewController = rootViewController
        sceneDelegate.window?.makeKeyAndVisible()
    }
}
