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
    
    var currentIndexPath: IndexPath? {
        didSet {
            if let currentIndexPath {
                avatarImageView = Profile().currentAvatars[currentIndexPath.row]
            }
        }
    }
    var unselectedIndexPath: IndexPath? {
        didSet {
            avatarImageView = Profile().unselectedAvatars[unselectedIndexPath!.row]
        }
    }
    
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
        self.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { $0.edges.equalTo(self) }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func configureData(_ indexPath: IndexPath) {
//        avatarImageView = Profile().unselectedAvatars[indexPath.row]
//    }
//    
//    func updateData(_ indexPath: IndexPath) {
//        avatarImageView = Profile().currentAvatars[indexPath.row]
//    }
}
