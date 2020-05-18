//
//  ByCategory.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-21.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class CategoriesPreview: UIView {
    
    var collectionView: UICollectionView! = UICollectionView(
    private var collectionViewHeaderLabel: Label! = Label()
    private let collectionViewHeader = "Offerings by Category"
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup view
    
    private func setupView() {
        backgroundColor = .white
        setupSubviews()
        setupConstraints()
    }
    
    //MARK: Setup subviews
    
    func setupSubviews() {
        setupCollectionViewHeader()
        addSubviews(collectionView, collectionViewHeaderLabel)
    }
    
    private func setupCollectionViewHeader() {
        collectionViewHeaderLabel.text = collectionViewHeader
        collectionViewHeaderLabel.font = Theme.standard.font.largeHeader
    }
}

// MARK: Constraints

extension CategoriesPreview {
    func setupConstraints() {
        setupConstraintsForCollectionViewHeader()
        setupConstraintsForCollectionView()
    }
    
    private func setupConstraintsForCollectionViewHeader() {
        collectionViewHeaderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    private func setupConstraintsForCollectionView() {
        collectionView.snp.makeConstraints { make in
            make.width.bottom.centerX.equalToSuperview()
            make.top.equalTo(collectionViewHeaderLabel.snp.bottom).offset(15)
        }
    }
}
