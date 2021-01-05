//
//  TimeCellViewModel.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 05/01/2021.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import Foundation

protocol TimeCellViewModelProtocol {
    func createTime(timestamp: Int) -> String
}

class TimeCellViewModel {
    
}

// MARK:- TimeCell ViewModel Protocol
extension TimeCellViewModel: TimeCellViewModelProtocol {
    func createTime(timestamp: Int) -> String {
        var strDate = ""
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
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
}
