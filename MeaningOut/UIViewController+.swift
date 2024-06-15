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
}
