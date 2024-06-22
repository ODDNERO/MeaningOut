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
        static let underline = UIColor.underline
        static let gray1 = UIColor.customGray1
        static let gray2 = UIColor.customGray2
        static let gray3 = UIColor.customGray3
        static let background = UIColor.white
        static let black = UIColor.black
    }
    
    enum Image {
        static let logo = UIImage(named: "Logo")
        static let launch = UIImage(named: "launch")
        static let empty = UIImage(named: "empty")
        static let search = UIImage(systemName: "magnifyingglass")
        static let person = UIImage(systemName: "person")
        static let right = UIImage(systemName: "chevron.right")
        static let clock = UIImage(systemName: "clock", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
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
        static let medium14 = UIFont.systemFont(ofSize: 14, weight: .medium)
        static let regular15 = UIFont.systemFont(ofSize: 14, weight: .regular)
        static let medium15 = UIFont.systemFont(ofSize: 15, weight: .medium)
        static let semi14 = UIFont.systemFont(ofSize: 14, weight: .semibold)
        static let semi15 = UIFont.systemFont(ofSize: 15, weight: .semibold)
        static let bold15 = UIFont.boldSystemFont(ofSize: 15)
        static let heavy16 = UIFont.systemFont(ofSize: 16, weight: .heavy)
        static let heavy18 = UIFont.systemFont(ofSize: 18, weight: .heavy)
        static let heavy20 = UIFont.systemFont(ofSize: 20, weight: .heavy)
        static let black15 = UIFont.systemFont(ofSize: 15, weight: .black)
        static let black16 = UIFont.systemFont(ofSize: 16, weight: .black)
    }
    
    enum TextField {
        static let nickname = {
            let textField = UITextField()
            textField.attributedPlaceholder = NSAttributedString(string: "닉네임을 입력해 주세요 :)", attributes: [.foregroundColor: Meaning.Color.gray2])
            textField.textColor = .black
            textField.tintColor = Meaning.Color.primary
            textField.font = Meaning.Font.semi14
            textField.layer.borderColor = UIColor.clear.cgColor
            return textField
        }()
        
        static let assistLabel = {
            let label = UILabel()
            label.font = Meaning.Font.medium13
            return label
        }()
    }
    
    enum Underline {
        static let navigationBar = {
            let view = UIView()
            view.backgroundColor = Meaning.Color.underline
            return view
        }()
        
        static let gray = {
            let view = UIView()
            view.backgroundColor = Meaning.Color.gray1
            return view
        }()
        
        static let black = {
            let view = UIView()
            view.backgroundColor = .black
            return view
        }()
    }
}
