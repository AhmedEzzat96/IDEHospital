//
//  MainCategoriesResponse.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 10/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation

struct MainCategoriesResponse: Codable {
    let data: [MainCategoriesData]
}

struct MainCategoriesData: Codable {
    let id: Int
    let name, image, color: String
}
