//
// Created by Jacob Goldfarb on 2020-03-29.
// Copyright (c) 2020 Project PJ. All rights reserved.
//

import Foundation

struct CurrencyFormatter {

    static func getFormattedString(from number: Double) -> String? {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        return currencyFormatter.string(from: NSNumber(value: number))
    }
}