//
//  UIView+.swift
//  MeaningOut
//
//  Created by NERO on 6/17/24.
//

import UIKit

extension UIView {
    func getUserImage() -> UIImage {
        let imageIndex = UserDefaults.standard.integer(forKey: "userImageIndex")
        return Meaning.Image.avatars[imageIndex]
    }
}
