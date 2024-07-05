//
//  EditProfileView.swift
//  MeaningOut
//
//  Created by NERO on 6/17/24.
//

import UIKit

final class EditProfileView: UIView {
    var editImageView = Profile().settingAvatars.randomElement()!
    let assistanceView = Profile().assistanceView
    
    let textField = Meaning.TextField.nickname
    let underlineView = Meaning.Underline.black
    let assistLabel = Meaning.TextField.assistLabel

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Meaning.Color.background
        editImageView.image = getUserImage()
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        editImageView.layer.cornerRadius = editImageView.bounds.width / 2.0
        assistanceView.layer.cornerRadius = assistanceView.bounds.width / 2.0
        editImageView.clipsToBounds = true
        assistanceView.clipsToBounds = true
    }
}

extension EditProfileView {
    private func configureHierarchy() {
        [editImageView, assistanceView, textField, underlineView, assistLabel].forEach { self.addSubview($0) }
    }
    
    private func configureLayout() {
        editImageView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
            $0.size.equalTo(100)
        }
        
        assistanceView.snp.makeConstraints {
            $0.bottom.equalTo(editImageView.snp.bottom)
            $0.trailing.equalTo(editImageView.snp.trailing)
            $0.size.equalTo(30)
        }
        
        textField.snp.makeConstraints {
            $0.horizontalEdges.equalTo(underlineView.snp.horizontalEdges).inset(10)
            $0.top.equalTo(editImageView.snp.bottom).offset(40)
        }
        
        underlineView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(25)
            $0.height.equalTo(1)
            $0.top.equalTo(textField.snp.bottom).offset(15)
        }
        
        assistLabel.snp.makeConstraints {
            $0.horizontalEdges.equalTo(underlineView.snp.horizontalEdges).inset(10)
            $0.top.equalTo(underlineView.snp.bottom).offset(10)
            $0.height.equalTo(textField.snp.height)
        }
    }
}
