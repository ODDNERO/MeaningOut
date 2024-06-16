//
//  SettingPictureView.swift
//  MeaningOut
//
//  Created by NERO on 6/16/24.
//

import UIKit

final class SettingPictureView: UIView {
    var settingImageView = UIImageView()
    let assistanceView = Profile().assistanceView
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 20
        let cellSpacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing * 3)
        
        layout.itemSize = CGSize(width: width/4, height: width/4)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }
    
//    var selectedIndexPath: IndexPath? {
//        didSet {
//            collectionView.reloadData()
//        }
//    }
    var unselectedIndexPath: IndexPath? = nil
        
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
        settingImageView.layer.cornerRadius = settingImageView.bounds.width / 2.0
        assistanceView.layer.cornerRadius = assistanceView.bounds.width / 2.0
        settingImageView.clipsToBounds = true
        assistanceView.clipsToBounds = true
    }
    
    private func configureSetting() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(AvatarCollectionViewCell.self, forCellWithReuseIdentifier: AvatarCollectionViewCell.identifier)
    }
}

extension SettingPictureView {
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

extension SettingPictureView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Meaning.Image.avatars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AvatarCollectionViewCell.identifier, for: indexPath) as! AvatarCollectionViewCell
        cell.configureData(indexPath)
//        cell.isSelected = (indexPath == self.selectedIndexPath)
//        cell.unselectedIndexPath = indexPath
//        cell.currentIndexPath = self.selectedIndexPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        settingImageView.image = Profile().settingAvatars[indexPath.row].image

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AvatarCollectionViewCell.identifier, for: indexPath) as! AvatarCollectionViewCell
        
        for num in 0...(collectionView.visibleCells.count - 1) {
            if indexPath.row == num {
                collectionView.visibleCells[num].isSelected = true
                cell.updateData(cell: collectionView.visibleCells[num])
            } else {
                collectionView.visibleCells[num].isSelected = false
                cell.updateData(cell: collectionView.visibleCells[num])
            }
        }
        print(indexPath)
        
        
        collectionView.reloadData()
//        selectedIndexPath = indexPath
//        settingImageView = Profile().settingAvatars[indexPath.row]
//        if let cell = collectionView.cellForItem(at: indexPath) as? AvatarCollectionViewCell {
//            cell.currentIndexPath = indexPath
//        }
    }
}
