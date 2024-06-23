//
//  SearchResultCollectionViewCell.swift
//  MeaningOut
//
//  Created by NERO on 6/23/24.
//

import UIKit
import SnapKit

final class SearchResultCollectionViewCell: UICollectionViewCell {
    var productImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private var favoriteButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.setImage(Meaning.Image.unselected, for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    private var isFavorite = false
    
    private let storeNameLabel = {
        let label = UILabel()
        label.textColor = Meaning.Color.gray1
        label.font = Meaning.Font.medium13
        label.textAlignment = .left
        return label
    }()
    private let productNameLabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Meaning.Font.medium14
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    private let priceLabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Meaning.Font.black15
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [productImageView, favoriteButton, storeNameLabel, productNameLabel, priceLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchResultCollectionViewCell {
    func setClickedFavoriteButtonUI(_ sender: UIButton) {
        isFavorite.toggle()
        switch isFavorite {
        case true:
            favoriteButton.setImage(Meaning.Image.selected, for: .normal)
            favoriteButton.backgroundColor = .white
            favoriteButton.alpha = 1
        case false:
            favoriteButton.setImage(Meaning.Image.unselected, for: .normal)
            favoriteButton.backgroundColor = Meaning.Color.gray2
            favoriteButton.alpha = 0.5
        }
    }
    
    private func configureLayout() {
        productImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        favoriteButton.snp.makeConstraints {
            $0.bottom.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            $0.size.equalTo(20)
        }
        
        storeNameLabel.snp.makeConstraints {
            $0.top.equalTo(productImageView.snp.bottom)
            $0.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        productNameLabel.snp.makeConstraints {
            $0.top.equalTo(storeNameLabel.snp.bottom)
            $0.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(productNameLabel.snp.bottom)
            $0.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
}
