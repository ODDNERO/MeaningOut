//
//  Profile.swift
//  MeaningOut
//
//  Created by NERO on 6/14/24.
//

import UIKit

final class Profile: UIImageView {
    let unselectedAvatars = {
        let avatars = AvatarImageView().avatars
        avatars.forEach { $0.alpha = 0.5 }
        return avatars
    }()
    
    let currentAvatars = {
        let avatars = AvatarImageView().avatars
        avatars.forEach {
            $0.layer.borderWidth = 3
            $0.layer.borderColor = Meaning.Color.primary.cgColor
        }
        return avatars
    }()
    
    let settingAvatars = {
        let avatars = AvatarImageView().avatars
        avatars.forEach {
            $0.contentMode = .scaleAspectFit
            $0.layer.borderWidth = 5
            $0.layer.borderColor = Meaning.Color.primary.cgColor
        }
        return avatars
    }()
    
    let assistanceView = {
        let image = Meaning.Image.camera
        let imageView = UIImageView(image: image)
        imageView.backgroundColor = Meaning.Color.primary
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
