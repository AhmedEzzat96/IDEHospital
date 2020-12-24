//
//  DoctorsFilter.swift
//  IDEHospital
//
//  Created by Ziad on 12/21/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation

struct DoctorsFilter {
    
    enum SortType: String {
        case rating
        case fees
    }
    
    
    let categoryId: Int!
    var page: Int!
    var specialtyId: Int?
    var cityId: Int?
    var regionId: Int?
    var doctorName: String?
    var companyId: Int?
    var orderBy: String?
    
    func parameters() -> [String: Any] {
        var params = [String: Any]()
        params[ParameterKeys.mainCategoryId] = categoryId
        params[ParameterKeys.page] = page
        params[ParameterKeys.specialtyId] = specialtyId
        params[ParameterKeys.cityId] = cityId
        params[ParameterKeys.regionId] = regionId
        params[ParameterKeys.name] = doctorName
        params[ParameterKeys.companyId] = companyId
        params[ParameterKeys.orderBy] = orderBy
        return params
    }
}
