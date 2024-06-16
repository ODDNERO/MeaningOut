//
//  SettingPictureViewController.swift
//  MeaningOut
//
//  Created by NERO on 6/14/24.
//

import UIKit

final class SettingPictureViewController: UIViewController {
    private let settingPictureView = SettingPictureView()
    var selectedImageView: UIImageView?
    
    override func loadView() {
        super.loadView()
        self.view = settingPictureView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingNavigation(title: "PROFILE SETTING", rightBarItem: nil)
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
        selectedImageView = settingPictureView.settingImageView
    }
}
