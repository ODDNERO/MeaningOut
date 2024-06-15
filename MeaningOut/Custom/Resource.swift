//
//  Resource.swift
//  MeaningOut
//
//  Created by NERO on 6/14/24.
//

import UIKit
import SnapKit

enum Meaning {
    enum Color {
        static let primary = UIColor.customOrange
        static let gray1 = UIColor.customGray1
        static let gray2 = UIColor.customGray2
        static let gray3 = UIColor.customGray3
        static let background = UIColor.white
        static let black = UIColor.black
    }
    
    enum Image {
        static let logo = UIImage(named: "Logo")
        static let launch = UIImage(named: "launch")
        static let search = UIImage(systemName: "magnifyingglass")
        static let person = UIImage(systemName: "person")
        static let right = UIImage(systemName: "chevron.right")
        static let clock = UIImage(systemName: "clock")
        static let remove = UIImage(systemName: "xmark")
        static let camera = UIImage(systemName: "camera.fill")
        static let avatars = {
            var avatars: [UIImage] = []
            let avatarNames = ["profile_0", "profile_1", "profile_2", "profile_3", "profile_4", "profile_5", "profile_6", "profile_7", "profile_8", "profile_9", "profile_10", "profile_11"]
            avatarNames.forEach { avatars.append(UIImage(named: $0)!) }
            return avatars
        }()
    }
    
    enum Font {
        static let medium13 = UIFont.systemFont(ofSize: 13, weight: .medium)
        static let semi14 = UIFont.systemFont(ofSize: 14, weight: .semibold)
        static let bold15 = UIFont.boldSystemFont(ofSize: 15)
        static let heavy16 = UIFont.systemFont(ofSize: 16, weight: .heavy)
    }
}
