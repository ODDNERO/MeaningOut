//
//  Profile.swift
//  MeaningOut
//
//  Created by NERO on 6/14/24.
//

import UIKit

final class Profile: UIImageView {
    private let basicAvatars = {
        let avatars = Meaning.ImageView.avatars
        avatars.forEach {
            $0.contentMode = .scaleAspectFill
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.black.cgColor
            $0.clipsToBounds = true
        }
        return avatars
    }()
    
    lazy var unselectedAvatars = {
        let avatars = self.basicAvatars
        avatars.forEach { $0.alpha = 0.5 }
        return avatars
    }()
    
    lazy var currentAvatars = {
        let avatars = self.basicAvatars
        avatars.forEach {
            $0.layer.borderWidth = 3
            $0.layer.borderColor = Meaning.Color.primary.cgColor
        }
        return avatars
    }()
    
    lazy var settingAvatars = {
        let avatars = self.basicAvatars
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
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = Meaning.Color.primary
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
