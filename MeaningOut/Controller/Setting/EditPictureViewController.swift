//
//  EditPictureViewController.swift
//  MeaningOut
//
//  Created by NERO on 6/17/24.
//

import UIKit

class EditPictureViewController: UIViewController {
    private let editPictureView = AvatarPickerView()
    
    override func loadView() {
        super.loadView()
        self.view = editPictureView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigation(title: "EDIT PROFILE", rightBarItem: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let avatarImageIndex = findAvatarImageIndex(editPictureView.settingImageView.image!)
        UserDefaults.standard.set(avatarImageIndex, forKey: "userImageIndex")
        UserDefaults.standard.set(true, forKey: "isModified")
    }
}
