//
//  Int+Timestamp.swift
//  IDEHospital
//
//  Created by Ziad on 1/8/21.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import Foundation

extension Int {
    func createTime() -> String {
        var strDate = ""
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        let timezone = TimeZone.current.abbreviation() ?? "CET"  // get current TimeZone abbreviation or set to CET
        dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = L10n.timeFormat //Specify your format that you want
        dateFormatter.amSymbol = L10n.am
        dateFormatter.pmSymbol = L10n.pm
        strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    func createDate() -> String {
        var strDate = ""
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        let timezone = TimeZone.current.abbreviation() ?? "CET"  // get current TimeZone abbreviation or set to CET
        dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = L10n.dateFormat //Specify your format that you want
        strDate = dateFormatter.string(from: date)
        return strDate
    }
}
