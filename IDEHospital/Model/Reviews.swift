//
//  Reviews.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 05/01/2021.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import Foundation

struct Reviews: Codable {
    let data: ReviewsData?
    let code: Int
    let success: Bool?
}

struct ReviewsData: Codable {
    let total_pages: Int
    let page: Int
    let items: [ReviewsItem]
}

struct ReviewsItem: Codable {
    let id: Int
    let rating: Int
    let comment: String
    let commented_by: String
}
