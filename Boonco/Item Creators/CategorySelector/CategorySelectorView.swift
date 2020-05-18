//
//  CategorySelectorView.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-31.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class CategorySelectorView: UIView {
    
    private let instructionLabel: UILabel!
    let categoriesTableView: UITableView!
    
    private let instructionText = "2. Choose Category"

    override init(frame: CGRect) {
        categoriesTableView = TableView()
        instructionLabel = Label()
        super.init(frame: frame)
        setupView()
        setupSubview()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        backgroundColor = .white
    }
    
    func setupSubview() {
        setupInstructionLabel()
        addSubviews(categoriesTableView, instructionLabel)
    }
    
    func setupConstraints() {
        setupConstraintsForInstructionLabel()
        setupConstraintsForTableView()
    }
    
    private func setupInstructionLabel() {
        instructionLabel.font = Theme.standard.font.largeHeader
        instructionLabel.text = instructionText
        instructionLabel.sizeToFit()
    }
    
    private func setupConstraintsForInstructionLabel() {
        instructionLabel.snp.remakeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).inset(20)
            make.leading.equalToSuperview().offset(24)
        }
    }
    
    private func setupConstraintsForTableView() {
        categoriesTableView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(instructionLabel.snp.bottom).offset(16)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(36)
        }
    }
}
