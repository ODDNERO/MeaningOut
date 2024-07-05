//
//  SettingPictureView.swift
//  MeaningOut
//
//  Created by NERO on 6/16/24.
//

import UIKit

final class AvatarPickerView: UIView {
    var settingImageView = UIImageView()
    private let assistanceView = Profile().assistanceView
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 20
        let cellSpacing: CGFloat = 15
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing * 3)
        
        layout.itemSize = CGSize(width: width/4, height: width/4)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return layout
    }
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Meaning.Color.background
        settingImageView = Profile().settingAvatars.randomElement()!
        
        configureSetting()
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        settingImageView.layer.cornerRadius = settingImageView.frame.width / 2.0
        assistanceView.layer.cornerRadius = assistanceView.frame.width / 2.0
        settingImageView.clipsToBounds = true
        assistanceView.clipsToBounds = true
    }
}

extension AvatarPickerView {
    private func configureSetting() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(AvatarCollectionViewCell.self, forCellWithReuseIdentifier: AvatarCollectionViewCell.identifier)
    }
    
    private func configureHierarchy() {
        [settingImageView, assistanceView, collectionView].forEach { self.addSubview($0) }
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
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(settingImageView.snp.bottom).offset(30)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}

extension AvatarPickerView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Meaning.Image.avatars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AvatarCollectionViewCell.identifier, for: indexPath) as! AvatarCollectionViewCell
        cell.configureData(indexPath)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellList = collectionView.visibleCells as! [AvatarCollectionViewCell]
        cellList[indexPath.row].updateData(cellList)
        
        settingImageView.image = Meaning.Image.avatars[indexPath.row]
    }
}
