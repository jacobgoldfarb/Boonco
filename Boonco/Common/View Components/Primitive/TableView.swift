//
//  TableView.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-28.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class TableView: UITableView {
    
    override var bounds: CGRect {
        didSet {
            updateView()
        }
    }
    
    var emptyIcon: UIImage?
    var emptyText: String?
    var emptyButtonHandler: ((UIButton) -> ())?

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView() {
        if self.visibleCells.isEmpty {
            updateEmptyView()
        } else {
            let view = UIView(frame: bounds)
            view.backgroundColor = .white
            self.backgroundView = view
        }
    }
    
    private func updateEmptyView() {
        let emptyView = EmptyTableViewBackground(frame: bounds, icon: emptyIcon, prompt: emptyText)
        self.backgroundView = emptyView
    }
    
    ///Note: not combining this with updateView because this will be used in viewWillAppear (we are not loading views here)
    func updateCellSeparatorLayout(isExiting: Bool = false) {
        if isExiting || !self.visibleCells.isEmpty {
            self.separatorStyle = .singleLine
        } else {
            self.separatorStyle = .none
        }
    }
}
