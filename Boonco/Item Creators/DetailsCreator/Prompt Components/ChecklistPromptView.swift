//
//  ChecklistPromptView.swift
//  Lender
//
//  Created by Peter Huang on 2020-04-15.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class ChecklistPromptView: UIView {
    
    //MARK: UIElements and constants

    var checklistPromptLabel: UILabel!
    var checklistDescriptionLabel: UILabel!
    var checklistTable: UITableView!
    
    let optionsList = ["Option 1", "Option 2", "Option 3"]
    
    private let checklistPrompt = "Options"
    private let checklistDescription = "Select all of the options that apply below"
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //MARK: Setup view
    
    private func setupView() {
        initiateSubviews()
        setupSubviews()
        setupConstraints()
    }
    
    private func initiateSubviews() {
        checklistPromptLabel = Label(frame: CGRect.zero)
        checklistDescriptionLabel = Label(frame: CGRect.zero)
        checklistTable = UITableView(frame: .zero, style: .plain)
    }
    
    private func setupSubviews() {
        checklistPromptLabel.text = checklistPrompt
        checklistPromptLabel.font = Theme.standard.font.header
        checklistPromptLabel.sizeToFit()
        
        checklistDescriptionLabel.text = checklistDescription
        checklistDescriptionLabel.font = Theme.standard.font.paragraph
        checklistDescriptionLabel.textColor = Theme.standard.colors.standardGray
        checklistDescriptionLabel.sizeToFit()
        checklistDescriptionLabel.adjustsFontSizeToFitWidth = true
        
        checklistTable.dataSource = self
        checklistTable.separatorStyle = .none;

        addSubviews(checklistPromptLabel, checklistDescriptionLabel, checklistTable)
    }
}

//MARK: Constraints

extension ChecklistPromptView {
    
    private func setupConstraints() {
        makeConstraintsForTitlePromptLabel()
        makeConstraintsForDescriptionLabel()
        makeConstraintsForChecklist()
    }
    
    private func makeConstraintsForTitlePromptLabel() {
        checklistPromptLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(24)
            make.top.equalToSuperview()
        }
    }
    
    private func makeConstraintsForDescriptionLabel() {
        checklistDescriptionLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(24)
            make.trailing.lessThanOrEqualToSuperview().offset(-24)
            make.top.equalTo(checklistPromptLabel.snp.bottom).offset(5)
        }
    }
    
    private func makeConstraintsForChecklist() {
        checklistTable.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-48)
            make.top.equalTo(checklistDescriptionLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview()
        }
    }
}

//MARK: Tableview data source and delegate

extension ChecklistPromptView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = optionsList[indexPath.row]
        cell.textLabel?.font = Theme.standard.font.regular
        cell.accessoryType = .none
        return cell
    }
}


