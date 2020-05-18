//
//  DropdownPromptView.swift
//  Lender
//
//  Created by Peter Huang on 2020-04-15.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

//MARK: Dropdown Prompt View

protocol DropdownButtonDelegate {
    func didPressButton(with option: RentalPeriod)
}

class DropdownPromptView: UIView {
    
    var button: DropdownButton!
    var selectedPeriod: RentalPeriod = .day
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        setupSubviews()
        setupConstraints()
    }
    
    ///Note: Special symbols source: https://www.unicode.org/charts/nameslist/n_25A0.html
    private func setupSubviews() {
        //Configure the button
        button = DropdownButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        button.setTitle("     /day    ▾", for: .normal) //▾ ▼
        button.delegate = self
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.dropView.dropDownOptions = RentalPeriod.allCases
        
        self.addSubview(button)
    }
    
    private func setupConstraints() {
        button.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
    }
}

extension DropdownPromptView: DropdownButtonDelegate {
    func didPressButton(with option: RentalPeriod) {
        selectedPeriod = option
    }
}

//MARK: Dropdown selector button

protocol DropdownProtocol {
    func dropdownPressed(with option: RentalPeriod)
}

class DropdownButton: UIButton, DropdownProtocol {
    
    var dropView = DropdownListView()
    var height = NSLayoutConstraint()
    var delegate: DropdownButtonDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.titleLabel?.font = Theme.standard.font.regular
        self.setTitleColor(UIColor.black, for: .normal)
        
        dropView = DropdownListView(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        dropView.delegate = self
        dropView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        self.superview?.addSubview(dropView)
        self.superview?.bringSubviewToFront(dropView)
        dropView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dropView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dropView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        height = dropView.heightAnchor.constraint(equalToConstant: 0)
    }
    
    func dropdownPressed(with option: RentalPeriod) {
        self.setTitle("    \(option.dropDownPrompt)   ▾", for: .normal)
        self.dismissDropdownMenu()
        delegate.didPressButton(with: option)
    }
    
    var isOpen = false
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isOpen == false {
            openDropdownMenu()
        } else {
            dismissDropdownMenu()
        }
    }
    
    func openDropdownMenu() {
        isOpen = true
        NSLayoutConstraint.deactivate([self.height])
        
        if self.dropView.tableview.contentSize.height > 144 {
            self.height.constant = 144
        } else {
            self.height.constant = self.dropView.tableview.contentSize.height
        }
        
        NSLayoutConstraint.activate([self.height])
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.dropView.layoutIfNeeded()
            self.dropView.center.y += self.dropView.frame.height / 2
        }, completion: nil)
    }
    
    func dismissDropdownMenu() {
        isOpen = false
        NSLayoutConstraint.deactivate([self.height])
        self.height.constant = 0
        NSLayoutConstraint.activate([self.height])
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.dropView.center.y -= self.dropView.frame.height / 2
            self.dropView.layoutIfNeeded()
        }, completion: nil)
    }
}

//MARK: Dropdown options list

class DropdownListView: UIView, UITableViewDelegate, UITableViewDataSource  {
    
    var dropDownOptions = [RentalPeriod]()
    var tableview = UITableView()
    var delegate : DropdownProtocol!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableview.backgroundColor = UIColor.white
        self.backgroundColor = UIColor.darkGray
        
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.separatorStyle = .none;
        tableview.layer.borderColor = UIColor.black.cgColor
        tableview.layer.borderWidth = 1

        
        self.addSubview(tableview)
        
        tableview.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableview.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableview.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropDownOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.white
        cell.textLabel?.text = dropDownOptions[indexPath.row].dropDownPrompt
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.font = Theme.standard.font.regular
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.dropdownPressed(with: dropDownOptions[indexPath.row])
        self.tableview.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 36
    }
}
