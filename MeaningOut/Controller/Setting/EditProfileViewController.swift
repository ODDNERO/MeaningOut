//
//  EditProfileViewController.swift
//  MeaningOut
//
//  Created by NERO on 6/17/24.
//

import UIKit

final class EditProfileViewController: UIViewController {
    private var saveButton = UIBarButtonItem()
    private let editProfileView = EditProfileView()
    
    override func loadView() {
        self.view = editProfileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigation(title: "EDIT PROFILE", rightBarItem: nil)
//        setNavigationBarUnderline()
        configureSetting()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.bool(forKey: "isModified") {
            editProfileView.editImageView.image = editProfileView.getUserImage()
            UserDefaults.standard.set(false, forKey: "isModified")
        } else {
            editProfileView.editImageView.image = editProfileView.getUserImage()
            editProfileView.textField.text = UserDefaults.standard.string(forKey: "userNickname")
        }
    }
}

extension EditProfileViewController {
    private func configureSetting() {
        saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        let attributes: [NSAttributedString.Key: Any] = [.font: Meaning.Font.heavy18]
        saveButton.setTitleTextAttributes(attributes, for: .normal)
        navigationItem.rightBarButtonItem = saveButton
        
        editProfileView.editImageView.isUserInteractionEnabled = true
        editProfileView.editImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(editImageViewClicked)))
        
        editProfileView.textField.addTarget(self, action: #selector(isValidNickname), for: .editingChanged)
    }
    
    @objc func editImageViewClicked() {
        navigationController?.pushViewController(EditPictureViewController(), animated: true)
    }
    
    @objc func saveButtonClicked() {
        guard isValidNickname(textField: editProfileView.textField) else { return }
        
        let avatarImageIndex = findAvatarImageIndex(editProfileView.editImageView.image!)
        UserDefaults.standard.set(avatarImageIndex, forKey: "userImageIndex")
        UserDefaults.standard.set(editProfileView.textField.text, forKey: "userNickname")
        UserDefaults.standard.set(true, forKey: "isModified")
        navigationController?.popViewController(animated: true)
    }
    
    @objc func isValidNickname(textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        editProfileView.assistLabel.textColor = Meaning.Color.primary
        
        let bannedStrings: CharacterSet = ["@", "#", "$", "%"]
        guard (text.rangeOfCharacter(from: bannedStrings) == nil) else {
            editProfileView.assistLabel.text = "닉네임에 @, #, $, % 는 포함할 수 없어요"
            return false
        }
    
        for character in text {
            guard !(character.isNumber) else {
                editProfileView.assistLabel.text = "닉네임에 숫자는 포함할 수 없어요"
                return false
            }
        }
        
        guard (2...9 ~= text.count) else {
            editProfileView.assistLabel.text = "2글자 이상 10글자 미만으로 설정해 주세요"
            return false
        }
        
        editProfileView.assistLabel.textColor = .black
        editProfileView.assistLabel.text = "사용 가능한 닉네임입니다 :D"
        return true
    }
}
