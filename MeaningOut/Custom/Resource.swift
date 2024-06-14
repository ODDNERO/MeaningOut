//
//  Resource.swift
//  MeaningOut
//
//  Created by NERO on 6/14/24.
//

import UIKit

enum Meaning {
    enum Color {
        static let primary = UIColor.customOrange
        static let gray1 = UIColor.customGray1
        static let gray2 = UIColor.customGray2
        static let gray3 = UIColor.customGray3
        static let black = UIColor.black
        static let white = UIColor.white
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
    }
    
    enum Font {
        static let bold15 = UIFont.boldSystemFont(ofSize: 15)
        static let heavy16 = UIFont.systemFont(ofSize: 16, weight: .heavy)
    }
}
