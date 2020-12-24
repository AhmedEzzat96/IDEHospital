//
//  MyAppointmentCellViewModel.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 21/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation
import SDWebImage

protocol MyAppointmentCellViewModelProtocol {
    func downloadImage(with item: MyAppointmentItem, completion: @escaping (UIImage?) -> Void)
    func createDate(timestamp: Int) -> String
    func createTime(timestamp: Int) -> String
}

class MyAppointmentCellViewModel {
    
}

//MARK:- MyFavoriteCell viewModel Protocol
extension MyAppointmentCellViewModel: MyAppointmentCellViewModelProtocol {
    func downloadImage(with item: MyAppointmentItem, completion: @escaping (UIImage?) -> Void) {
        SDWebImageManager.shared.loadImage(with: URL(string: item.doctor.image), options: .highPriority, progress: nil) { (image, _, error, _, _, _) in
            if let error = error {
                print(error.localizedDescription)
            } else if let image = image {
                completion(image)
            }
        }
    }
    
    func createDate(timestamp: Int) -> String {
        var strDate = ""
        
        
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        let timezone = TimeZone.current.abbreviation() ?? "CET"  // get current TimeZone abbreviation or set to CET
        dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = L10n.dateFormat //Specify your format that you want
        strDate = dateFormatter.string(from: date)
        
        return strDate
    }
    
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
