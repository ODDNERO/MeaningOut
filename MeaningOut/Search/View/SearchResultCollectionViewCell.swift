//
//  SearchResultCollectionViewCell.swift
//  MeaningOut
//
//  Created by NERO on 6/23/24.
//

import UIKit
import SnapKit
import Kingfisher

final class SearchResultCollectionViewCell: UICollectionViewCell {
    var productImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    var wishButton = {
        let button = UIButton()
        button.tintColor = .black
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return button
    }()
    
    private let storeNameLabel = {
        let label = UILabel()
        label.textColor = Meaning.Color.gray1
        label.font = Meaning.Font.medium12
        label.textAlignment = .left
        return label
    }()
    private let productNameLabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Meaning.Font.medium13
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    private let priceLabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Meaning.Font.heavy16
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [productImageView, wishButton, storeNameLabel, productNameLabel, priceLabel].forEach {
            contentView.addSubview($0)
        }
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchResultCollectionViewCell {
    func update(data: Item) {
        let url = URL(string: data.image)
        productImageView.kf.setImage(with: url)
        storeNameLabel.text = data.mallName
        let cleanProductName = Meaning.Method.removeHTMLTags(text: data.title)
        productNameLabel.text = cleanProductName
        let price = Meaning.Method.formatNumber(Int(data.lprice)!)
        priceLabel.text = "\(price)원"
        
        let repository = WishItemRepository()
        let isWished = repository.isItemInWishlist(findProductID: data.productId)
        switch isWished {
        case true: configureWishButtonUI(true)
        case false: configureWishButtonUI(false)
        }
    }
    
    func configureWishButtonUI(_ isWish: Bool) {
        switch isWish {
        case true:
            wishButton.setImage(Meaning.Image.selected, for: .normal)
            wishButton.backgroundColor = UIColor.white.withAlphaComponent(1.0)
        case false:
            wishButton.setImage(Meaning.Image.unselected, for: .normal)
            wishButton.backgroundColor = Meaning.Color.gray2.withAlphaComponent(0.4)
        }
    }
    
    private func configureLayout() {
        productImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            $0.height.equalTo(200)
        }
        
        wishButton.snp.makeConstraints {
            $0.bottom.trailing.equalTo(productImageView).inset(13)
            $0.size.equalTo(30)
        }
        
        storeNameLabel.snp.makeConstraints {
            $0.top.equalTo(productImageView.snp.bottom).offset(7)
            $0.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        productNameLabel.snp.makeConstraints {
            $0.top.equalTo(storeNameLabel.snp.bottom).offset(4)
            $0.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(productNameLabel.snp.bottom).offset(4)
            $0.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
}
