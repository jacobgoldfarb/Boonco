//
//  CategoryTableViewCell.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-31.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    let iconView: UIImageView!
    private let categoryLabel: UILabel!
    
    var category: Category! {
        didSet {
            categoryLabel.text = category.description
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        iconView = UIImageView()
        categoryLabel = Label()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        iconView.contentMode = .scaleAspectFit
        addSubviews(iconView, categoryLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        setupConstraintsForImageView()
        setupConstraintsForLabel()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupConstraintsForImageView() {
        iconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().inset(7.5)
            make.width.equalTo(snp.height).inset(7.5)
        }
    }
    
    private func setupConstraintsForLabel() {
        categoryLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconView.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }
    }

}
