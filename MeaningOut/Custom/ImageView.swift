//
//  ImageView.swift
//  MeaningOut
//
//  Created by NERO on 6/14/24.
//

import UIKit

extension Meaning {
    enum ImageView {
        static let logo = {
            let logoView = UIImageView(image: Meaning.Image.logo)
            logoView.tintColor = Meaning.Color.primary
            logoView.contentMode = .scaleAspectFit
            return logoView
        }()
        
        static let launch = {
            let launchView = UIImageView(image: Meaning.Image.launch)
            launchView.contentMode = .scaleAspectFill
            return launchView
        }()
    }
}

struct AvatarImageView {
    let avatars = {
        var avatarViews: [UIImageView] = []
        Meaning.Image.avatars.forEach { avatarViews.append(UIImageView(image: $0)) }
        avatarViews.forEach {
            $0.contentMode = .scaleAspectFill
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.black.cgColor
            $0.clipsToBounds = true
        }
        return avatarViews
    }()
}
