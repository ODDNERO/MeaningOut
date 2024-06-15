//
//  SettingProfileViewController.swift
//  MeaningOut
//
//  Created by NERO on 6/14/24.
//

import UIKit

class SettingProfileViewController: UIViewController {
    private let settingProfileView = SettingProfileView()
    
    override func loadView() {
        self.view = settingProfileView
        settingNavigation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingProfileView.settingImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(settingImageViewClicked)))
        settingProfileView.finishButton.addTarget(self, action: #selector(finishButtonClicked), for: .touchUpInside)
        settingProfileView.textField.addTarget(self, action: #selector(isValidNickname), for: .editingChanged)
    }
}

//MARK: - Switching View
extension SettingProfileViewController {
    func settingNavigation() {
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "PROFILE SETTING"
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black
        ]
    }
    
    @objc func settingImageViewClicked() {
        navigationController?.pushViewController(SettingPictureViewController(), animated: true)
    }
    
    @objc func finishButtonClicked() {
        
    }
    
    @objc func isValidNickname(textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        settingProfileView.assistLabel.textColor = Meaning.Color.primary
        
        let bannedStrings: CharacterSet = ["@", "#", "$", "%"]
        guard (text.rangeOfCharacter(from: bannedStrings) == nil) else {
            settingProfileView.assistLabel.text = "닉네임에 @, #, $, % 는 포함할 수 없어요"
            return false
        }
        
        guard (Int(text) == nil) else {
            settingProfileView.assistLabel.text = "닉네임에 숫자는 포함할 수 없어요"
            return false
        }
        
        guard (2...9 ~= text.count) else {
            settingProfileView.assistLabel.text = "2글자 이상 10글자 미만으로 설정해 주세요"
            return false
        }
        
        settingProfileView.assistLabel.textColor = .black
        settingProfileView.assistLabel.text = "사용 가능한 닉네임입니다 :D"
        return true
    }
}
