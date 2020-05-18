//
//  InactiveProfilePreview.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-16.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class InactiveProfilePreview: ProfilePreview {
    
    let headerLabel: Label = Label()
    let bodyLabel: Label = Label()
    
    var header: String? {
        didSet {
            headerLabel.text = header
        }
    }
    
    var body: String? {
        didSet {
            bodyLabel.text = body
        }
    }

    override func setupSubviews() {
        super.setupSubviews()
        headerLabel.font = Theme.standard.font.largeHeader
        headerLabel.textAlignment = .center
        bodyLabel.textAlignment = .center
        addSubviews(bodyLabel, headerLabel)
    }
    
    override func setupConstraints() {
        setupConstraintsForBodyLabel()
        setupConstraintsForHeaderLabel()
    }
    
    func setupConstraintsForBodyLabel() {
        bodyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(30)
            make.width.equalToSuperview().inset(20)
        }
    }
    
    func setupConstraintsForHeaderLabel() {
        headerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(bodyLabel.snp.top).offset(-10)
            make.width.equalToSuperview().inset(20)
        }
    }
}
