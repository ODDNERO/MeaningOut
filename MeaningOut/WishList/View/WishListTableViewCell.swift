//
//  WishListTableViewCell.swift
//  MeaningOut
//
//  Created by NERO on 7/6/24.
//

import UIKit
import SnapKit
import Kingfisher

class WishListTableViewCell: UITableViewCell {
    private let itemImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let itemNameLabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Meaning.Font.bold15
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    private let storeNameLabel = {
        let label = UILabel()
        label.textColor = Meaning.Color.gray1
        label.font = Meaning.Font.medium12
        label.textAlignment = .left
        return label
    }()
    private let priceLabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Meaning.Font.bold15
        label.textAlignment = .left
        return label
    }()
    
    private let wishDateLabel = {
        let label = UILabel()
        label.textColor = Meaning.Color.primary.withAlphaComponent(0.5)
        label.font = Meaning.Font.medium12
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    let wishButton = {
        let button = UIButton()
        button.tintColor = Meaning.Color.primary
        button.setImage(Meaning.Image.selected, for: .normal)
        button.backgroundColor = UIColor.white.withAlphaComponent(1.0)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WishListTableViewCell {
    func update(data: WishItem) {
        let url = URL(string: data.imageString)
        itemImageView.kf.setImage(with: url)
        itemNameLabel.text = data.title
        storeNameLabel.text = data.mallName
        priceLabel.text = data.price
        wishDateLabel.text = data.wishDate
    }
}

extension WishListTableViewCell {
    private func configureHierarchy() {
        [itemImageView, itemNameLabel, storeNameLabel, priceLabel, wishDateLabel, wishButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func configureLayout() {
        itemImageView.snp.makeConstraints {
            $0.leading.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            $0.centerY.equalTo(contentView.safeAreaLayoutGuide)
            $0.size.equalTo(100)
        }
        storeNameLabel.snp.makeConstraints {
            $0.leading.equalTo(itemImageView.snp.trailing).offset(10)
            $0.top.equalTo(contentView.safeAreaLayoutGuide).offset(8)
            $0.height.equalTo(15)
        }
        itemNameLabel.snp.makeConstraints {
            $0.leading.equalTo(itemImageView.snp.trailing).offset(10)
            $0.trailing.equalTo(wishButton.snp.leading)
            $0.top.equalTo(storeNameLabel.snp.bottom).offset(4)
        }
        priceLabel.snp.makeConstraints {
            $0.leading.equalTo(itemImageView.snp.trailing).offset(10)
            $0.top.equalTo(contentView.safeAreaLayoutGuide.snp.centerY).offset(12)
        }
        wishDateLabel.snp.makeConstraints {
            $0.trailing.equalTo(wishButton.snp.trailing).inset(15)
            $0.top.equalTo(priceLabel.snp.bottom)
        }
        wishButton.snp.makeConstraints {
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide)
            $0.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.centerY).offset(15)
            $0.size.equalTo(70)
        }
    }
}
