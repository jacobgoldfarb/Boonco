//
//  CategoryCollectionViewCell.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-21.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    private var imageView: UIImageView = RoundImageView()
    private var label: Label = Label()
    
    var categoryText: String? {
        didSet {
            label.text = categoryText
        }
    }
    var icon: UIImage? {
        didSet {
            imageView.image = icon
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews(label, imageView)
        setupConstraints()
        imageView.contentMode = .scaleAspectFill
        label.font = Theme.standard.font.small
        label.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().inset(10)
            make.width.equalTo(snp.height).inset(10)
            make.centerY.equalToSuperview().offset(-15)
        }
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.width.equalToSuperview().inset(10)
        }
    }
    
}
