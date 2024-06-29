//
//  SettingProfileViewController.swift
//  MeaningOut
//
//  Created by NERO on 6/14/24.
//

import UIKit

final class SettingProfileViewController: UIViewController {
    private let settingProfileView = SettingProfileView()
    
    override func loadView() {
        self.view = settingProfileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigation(title: "PROFILE SETTING", rightBarItem: nil)
        configureSetting()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.bool(forKey: "isCache") {
            settingProfileView.settingImageView.image = settingProfileView.getUserImage()
        } else {
            settingProfileView.textField.text = nil
        }
    }
}

extension SettingProfileViewController {
    private func configureSetting() {
        settingProfileView.settingImageView.image = Meaning.Image.avatars.randomElement()!
        settingProfileView.settingImageView.isUserInteractionEnabled = true
        settingProfileView.settingImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(settingImageViewClicked)))
        
        settingProfileView.finishButton.addTarget(self, action: #selector(finishButtonClicked), for: .touchUpInside)
        settingProfileView.textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        settingProfileView.assistLabel.text = ""
    }
    
    @objc func settingImageViewClicked() {
        navigationController?.pushViewController(SettingPictureViewController(), animated: true)
    }
    
    @objc func finishButtonClicked() {
        guard setNicknameValidationResult(textField: settingProfileView.textField, changeTextLabel: settingProfileView.assistLabel) else {
            return
        }
        
        let avatarImageIndex = findAvatarImageIndex(settingProfileView.settingImageView.image!)
        UserDefaults.standard.set(avatarImageIndex, forKey: "userImageIndex")
        UserDefaults.standard.set(settingProfileView.textField.text, forKey: "userNickname")
        UserDefaults.standard.set(true, forKey: "isUser")
        
        saveJoinDate()
        designateRootVC(TabBarController())
    }
    
    private func saveJoinDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let currentDate = dateFormatter.string(from: Date())
        
        UserDefaults.standard.set(currentDate, forKey: "userJoinDate")
    }
    
    @objc func textFieldEditingChanged(textField: UITextField) {
        guard setNicknameValidationResult(textField: textField, changeTextLabel: settingProfileView.assistLabel) else {
            return
        }
    }
}
