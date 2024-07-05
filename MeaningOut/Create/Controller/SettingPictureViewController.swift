//
//  SettingPictureViewController.swift
//  MeaningOut
//
//  Created by NERO on 6/14/24.
//

import UIKit

final class SettingPictureViewController: UIViewController {
    private let settingPictureView = AvatarPickerView()
    
    override func loadView() {
        self.view = settingPictureView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigation(title: "PROFILE SETTING", rightBarItem: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let avatarImageIndex = findAvatarImageIndex(settingPictureView.settingImageView.image!)
        UserDefaults.standard.set(avatarImageIndex, forKey: "userImageIndex")
        UserDefaults.standard.set(true, forKey: "isCache")
    }
}
