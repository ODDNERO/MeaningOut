//
//  AvatarCollectionViewCell.swift
//  MeaningOut
//
//  Created by NERO on 6/16/24.
//

import UIKit

final class AvatarCollectionViewCell: UICollectionViewCell {
    private var avatarImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.alpha = 0.5
        imageview.layer.borderWidth = 1
        imageview.layer.borderColor = UIColor.black.cgColor
        return imageview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        contentView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { $0.edges.equalTo(contentView) }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layoutIfNeeded()
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2.0
        avatarImageView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureData(_ indexPath: IndexPath) {
        let avatars = Meaning.Image.avatars[indexPath.row]
        avatarImageView.image = avatars
    }
    
    func updateData(_ cellList: [AvatarCollectionViewCell]) {
        for num in 0...(cellList.count - 1) {
            let cell = cellList[num]
            cell.avatarImageView.layer.borderWidth = cell.isSelected ? 3 : 1
            cell.avatarImageView.layer.borderColor = cell.isSelected ? Meaning.Color.primary.cgColor : UIColor.black.cgColor
            cell.avatarImageView.alpha = cell.isSelected ? 1.0 : 0.5
        }
    }
}


