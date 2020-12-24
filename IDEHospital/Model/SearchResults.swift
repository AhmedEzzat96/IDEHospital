//
//  SearchResults.swift
//  IDEHospital
//
//  Created by Ziad on 12/20/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation

struct SearchResponse: Codable {
    let success: Bool
    let data: SearchResults
    let code: Int
}

struct SearchResults: Codable {
    let totalPages: Int
    var items: [DoctorResultsResponse]
    
    enum CodingKeys: String, CodingKey {
        case items
        case totalPages = "total_pages"
    }
}


struct DoctorResultsResponse: Codable {
    let id: Int
    let rating: Int
    let reviewsCount: Int
    let specialty: String
    let name: String
    let secondBio: String
    let address: String
    let fees : Int
    let waitingTime: Int
    let image: String
    let city: String
    let region: String
    let companies: [String]
    var isFavorited: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, rating, specialty, name, address, fees, image, city, region, companies
        case reviewsCount = "reviews_count"
        case secondBio = "second_bio"
        case waitingTime = "waiting_time"
        case isFavorited = "is_favorited"
    }
}
