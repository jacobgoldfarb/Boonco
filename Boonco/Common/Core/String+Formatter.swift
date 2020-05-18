//
//  String+Formatter.swift
//  Boonco
//
//  Created by Peter Huang on 2020-05-08.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation

extension String {
    public static let notApplicable = "N/A"
    public static let loadingText = "Loading"
    public static let timeoutText = "Timeout"
        
    public func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    public func substring(with nsrange: NSRange) -> String? {
        guard let range = Range(nsrange, in: self) else { return nil }
        return String(self[range])
    }
    
    public static func percentage(originString: String?) -> String {
        guard let originString = originString, let percentageDouble = Double(originString) else {
            return "N/A"
        }
        return String(format: "%.1f%%", percentageDouble)
    }
}
