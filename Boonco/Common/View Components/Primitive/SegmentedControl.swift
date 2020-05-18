//
//  PBSegmentedControl.swift
//  Lender
//
//  Created by Peter Huang on 2020-04-01.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class SegmentedControl: UISegmentedControl {
    
    //MARK: Global variables and constants
    
    private let selectedColor = Theme.standard.colors.violetBlue
    private let normalColor = Theme.standard.colors.davysGray
    
    private let radius: CGFloat = 5.0
    
    override var bounds: CGRect {
        didSet {
            setupBorders()
        }
    }
    
    //MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    override init(items: [Any]?) {
        super.init(items: items)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //MARK: Segmented Control View

    func setupView() {
        clipsToBounds = true
    }
    
    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.05
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 5
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
    }
    
    //MARK: Set up custom border style
    
    private func removeBorder() {
        let font = Theme.standard.font.header
        backgroundColor = UIColor.clear
        tintColor = UIColor.clear
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor : selectedColor], for: .selected)
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor : selectedColor], for: .highlighted)
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor : normalColor,
                                NSAttributedString.Key.font : font], for: .normal)
    }
    
    private func addUnderlineForSelectedSegment() {
        let underlineWidth: CGFloat = self.bounds.size.width / CGFloat(self.numberOfSegments) - (2 * radius)
        let underlineHeight: CGFloat = 2.0
        let underlineXPosition = CGFloat(selectedSegmentIndex * Int(underlineWidth)) + radius
        let underlineYPosition = self.bounds.size.height - 1.0
        let underlineFrame = CGRect(x: underlineXPosition, y: underlineYPosition, width: underlineWidth, height: underlineHeight)
        let underline = UIView(frame: underlineFrame)
        underline.backgroundColor = selectedColor
        underline.tag = 1001
        self.addSubview(underline)
    }
    
    private func setupBorders() {
        removeBorder()
        let segmentUnderlineWidth: CGFloat = self.bounds.width
        let segmentUnderlineHeight: CGFloat = 2.0
        let segmentUnderlineXPosition = self.bounds.minX
        let segmentUnderlineYPosition = self.bounds.size.height - 1.0
        let segmentUnderlineFrame = CGRect(x: segmentUnderlineXPosition, y: segmentUnderlineYPosition,
                                           width: segmentUnderlineWidth, height: segmentUnderlineHeight)
        let segmentUnderline = UIView(frame: segmentUnderlineFrame)
        
        addSubview(segmentUnderline)
        addUnderlineForSelectedSegment()
    }
    
    //MARK: Set up segmented control view on change
    
    func changeUnderlinePosition() {
        //TODO: get rid of the tag in the future
        guard let underline = self.viewWithTag(1001) else { return }
        let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)
        underline.frame.origin.x = underlineFinalXPosition + radius
    }
    
}

///NOTE: in iOS13 Apple changed the look of segmented controls
///Reference: https://prograils.com/posts/how-i-solved-a-segmented-control-design-problem-in-ios-13
///One possible solution is to gate what segmented control to use: iOS13 and above or older versions
///The current segmented control in iOS12 is matches the design specs
