//
//  UIViewController+.swift
//  MeaningOut
//
//  Created by NERO on 6/16/24.
//

import UIKit
import SnapKit

extension UIViewController {
    func setNicknameValidationResult(textField: UITextField, changeTextLabel: UILabel) -> Bool {
        changeTextLabel.textColor = Meaning.Color.primary
        do {
            try validateNicknameError(textField: textField)
        } catch {
            switch error {
            case InputValidation.emptyText:
                return false
            case InputValidation.invalidSpecialCharacter:
                changeTextLabel.text = "닉네임에 @, #, $, % 는 포함할 수 없어요"
                return false
            case InputValidation.invalidInt:
                changeTextLabel.text = "닉네임에 숫자는 포함할 수 없어요"
                return false
            case InputValidation.InvalidLength:
                changeTextLabel.text = "2글자 이상 10글자 미만으로 설정해 주세요"
                return false
            default:
                return false
            }
        }
        changeTextLabel.textColor = .black
        changeTextLabel.text = "사용 가능한 닉네임입니다 :D"
        return true
    }
    
    func validateNicknameError(textField: UITextField) throws {
        guard let text = textField.text else {
            throw InputValidation.emptyText
        }
        let bannedStrings: CharacterSet = ["@", "#", "$", "%"]
        guard (text.rangeOfCharacter(from: bannedStrings) == nil) else {
            throw InputValidation.invalidSpecialCharacter
        }
        for character in text {
            guard !(character.isNumber) else {
                throw InputValidation.invalidInt
            }
        }
        guard (2...9 ~= text.count) else {
            throw InputValidation.InvalidLength
        }
    }
    
    func findAvatarImageIndex(_ inputImage: UIImage) -> Int? {
        for (index, image) in Meaning.Image.avatars.enumerated() {
            if image == inputImage {
                return index
            }
        }
        return nil
    }
    
    func settingNavigation(title: String, rightBarItem: UIBarButtonItem?) {
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = title
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationItem.rightBarButtonItem = rightBarItem
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() //underline
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    func removeNavigationBarUnderline() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    func showAlert(title: String, message: String, okText: String, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: okText, style: .destructive) { _ in completionHandler() }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func designateRootVC(_ VC: UIViewController) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let sceneDelegate = windowScene.delegate as? SceneDelegate else { return }
        
        if VC is UITabBarController {
            sceneDelegate.window?.rootViewController = VC
        } else {
            sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: VC)
        }
        sceneDelegate.window?.makeKeyAndVisible()
    }
}
