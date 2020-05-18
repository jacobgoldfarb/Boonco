//
//  Font.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-27.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

struct Font {
    //Family: "Poppins Font", names: ["Poppins-Bold", "Poppins-Medium", "Poppins-Regular", "Poppins-SemiBold"]
    static private let tinySize: CGFloat = 11
    static private let smallSize: CGFloat = 13
    static private let defaultSize: CGFloat = 16
    static private let largeHeaderSize: CGFloat = 24
    static private let detailHeaderSize: CGFloat = 22
    static private let paragraphSize: CGFloat = 15

    let small = UIFont(name: "Poppins-Regular", size: Font.smallSize)!
    let regular = UIFont(name: "Poppins-Regular", size: Font.defaultSize)!
    let header = UIFont(name: "Poppins-SemiBold", size: Font.defaultSize)!
    let largeHeader = UIFont(name: "Poppins-SemiBold", size: Font.largeHeaderSize)!
    let detailHeader = UIFont(name: "Poppins-SemiBold", size: Font.detailHeaderSize)!
    let regularDetailHeader = UIFont(name: "Poppins-Regular", size: Font.detailHeaderSize)!
    let subHeader = UIFont(name: "Poppins-Regular", size: Font.smallSize)!
    let cellSubHeader = UIFont(name: "Poppins-Regular", size: Font.tinySize)!
    let paragraph = UIFont(name: "Poppins-Regular", size: Font.paragraphSize)!
}
