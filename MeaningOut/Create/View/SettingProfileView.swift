//
//  SettingProfileView.swift
//  MeaningOut
//
//  Created by NERO on 6/14/24.
//

import UIKit

final class SettingProfileView: UIView {
    var settingImageView = UIImageView()
    let assistanceView = Profile().assistanceView
    
    let textField = Meaning.TextField.nickname
    let underlineView = Meaning.Underline.gray
    let assistLabel = Meaning.TextField.assistLabel

    let finishButton = NextButton(title: "완료")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Meaning.Color.background
        settingImageView = Profile().settingAvatars.randomElement()!
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        settingImageView.layer.cornerRadius = settingImageView.bounds.width / 2.0
        assistanceView.layer.cornerRadius = assistanceView.bounds.width / 2.0
        settingImageView.clipsToBounds = true
        assistanceView.clipsToBounds = true
    }
}

extension SettingProfileView {
    private func configureHierarchy() {
        [settingImageView, assistanceView, textField, underlineView, assistLabel, finishButton].forEach { self.addSubview($0) }
    }
    
    private func configureLayout() {
        settingImageView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
            $0.size.equalTo(100)
        }
        
        assistanceView.snp.makeConstraints {
            $0.bottom.equalTo(settingImageView.snp.bottom)
            $0.trailing.equalTo(settingImageView.snp.trailing)
            $0.size.equalTo(30)
        }
        
        textField.snp.makeConstraints {
            $0.horizontalEdges.equalTo(underlineView.snp.horizontalEdges).inset(10)
            $0.top.equalTo(settingImageView.snp.bottom).offset(40)
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
        
        finishButton.snp.makeConstraints {
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
            $0.width.equalTo(self).multipliedBy(0.9)
            $0.height.equalTo(finishButton.snp.width).multipliedBy(1.0 / 8.0)
            $0.top.equalTo(assistLabel.snp.bottom).offset(30)
        }
    }
}
