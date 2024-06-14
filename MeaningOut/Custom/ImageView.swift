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
