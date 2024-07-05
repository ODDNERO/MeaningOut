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
        
        editProfileView.textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }
    
    @objc func editImageViewClicked() {
        navigationController?.pushViewController(EditPictureViewController(), animated: true)
    }
    
    @objc func saveButtonClicked() {
        guard setNicknameValidationResult(textField: editProfileView.textField, changeTextLabel: editProfileView.assistLabel) else {
            return
        }
        
        let avatarImageIndex = findAvatarImageIndex(editProfileView.editImageView.image!)
        UserDefaults.standard.set(avatarImageIndex, forKey: "userImageIndex")
        UserDefaults.standard.set(editProfileView.textField.text, forKey: "userNickname")
        UserDefaults.standard.set(true, forKey: "isModified")
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textFieldEditingChanged(textField: UITextField) {
        guard setNicknameValidationResult(textField: textField, changeTextLabel: editProfileView.assistLabel) else {
            return
        }
    }
}
