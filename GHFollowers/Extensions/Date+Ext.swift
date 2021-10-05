//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Wilson Sanchez on 1/24/20.
//  Copyright © 2020 wtech22. All rights reserved.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
