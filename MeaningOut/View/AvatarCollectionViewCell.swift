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
        imageview.clipsToBounds = true
        return imageview
    }()
    
//    override var isSelected: Bool {
//        didSet {
//            if isSelected {
//                avatarImageView.layer.borderWidth = 3
//                avatarImageView.layer.borderColor = Meaning.Color.primary.cgColor
//                avatarImageView.alpha = 1.0
//            } else {
//                avatarImageView.layer.borderWidth = 1
//                avatarImageView.layer.borderColor = UIColor.black.cgColor
//                avatarImageView.alpha = 0.5
//            }
//        }
//    }
    
    //    override var isSelected: Bool {
    //        didSet {
    //            if isSelected {
    //                avatarImageView = Profile().currentAvatars[currentIndexPath!.row]
    //            } else {
    //                avatarImageView = Profile().unselectedAvatars[unselectedIndexPath!.row]
    //            }
    //        }
    //    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        contentView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { $0.edges.equalTo(contentView) }
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2.0
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureData(_ indexPath: IndexPath) {
        let avatars = Meaning.Image.avatars[indexPath.row]
        avatarImageView.image = avatars
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.borderColor = UIColor.black.cgColor
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2.0
        avatarImageView.alpha = 0.5
        //        avatarImageView = Profile().unselectedAvatars[indexPath.row]
        
        //        var avatars = Meaning.Image.avatars[indexPath.row]
        //        avatars.forEach {
        //            $0.contentMode = .scaleAspectFill
        //            $0.layer.borderWidth = 1
        //            $0.layer.borderColor = UIColor.black.cgColor
        //            $0.clipsToBounds = true
        //        }
    }
    
    func updateData(cell: UICollectionViewCell) {
        //        avatarImageView = Profile().currentAvatars[indexPath.row]
        
        if isSelected {
            cell.contentView.layer.borderWidth = 3
            cell.contentView.layer.borderColor = Meaning.Color.primary.cgColor
            cell.contentView.alpha = 1.0
//            avatarImageView.layer.borderWidth = 3
//            avatarImageView.layer.borderColor = Meaning.Color.primary.cgColor
//            avatarImageView.alpha = 1.0
        } else {
            cell.contentView.layer.borderWidth = 1
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.contentView.alpha = 0.5
//            avatarImageView.layer.borderWidth = 1
//            avatarImageView.layer.borderColor = UIColor.black.cgColor
//            avatarImageView.alpha = 0.5
        }
    }
}

