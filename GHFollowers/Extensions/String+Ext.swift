//
//  String+Ext.swift
//  GHFollowers
//
//  Created by Wilson Sanchez on 1/24/20.
//  Copyright © 2020 wtech22. All rights reserved.
//

import Foundation

extension String {
    func convertToDate () -> Date? {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "yyyy-MM-dd'T'HH:mm:ssZ"  //this string needs to be exactly the same as on the server
        dateFormatter.locale        = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone      = .current
        
        return dateFormatter.date(from: self)
    }
    
    func convertToDisplayFormat () -> String {
        //converting string to date
        guard let date = self.convertToDate() else { return "N/A" }
        
        return date.convertToMonthYearFormat()
    }
    
}
