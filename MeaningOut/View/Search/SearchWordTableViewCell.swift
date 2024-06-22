//
//  SearchWordTableViewCell.swift
//  MeaningOut
//
//  Created by NERO on 6/22/24.
//

import UIKit
import SnapKit

final class SearchWordTableViewCell: UITableViewCell {
    private let clockImageView = {
        let imageView = UIImageView()
        imageView.image = Meaning.Image.clock
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let wordLabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = Meaning.Font.medium14
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let removeButton = {
        let button = UIButton()
        button.setImage(Meaning.Image.remove, for: .normal)
        button.tintColor = .black
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [clockImageView, wordLabel, removeButton].forEach { contentView.addSubview($0) }
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchWordTableViewCell {
    func update(word: String) {
        wordLabel.text = word
    }
    
    private func configureLayout() {
        clockImageView.snp.makeConstraints {
            $0.centerY.equalTo(contentView.safeAreaLayoutGuide)
            $0.leading.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            $0.size.equalTo(17)
        }
        wordLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView.safeAreaLayoutGuide)
            $0.leading.equalTo(clockImageView.snp.trailing).offset(15)
            $0.trailing.equalTo(removeButton.snp.leading).inset(20)
        }
        removeButton.snp.makeConstraints {
            $0.centerY.equalTo(contentView.safeAreaLayoutGuide)
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            $0.size.equalTo(13)
        }
    }
}
