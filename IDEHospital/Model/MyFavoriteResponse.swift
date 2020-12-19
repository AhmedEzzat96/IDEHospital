//
//  MyFavoriteResponse.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 18/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation

struct MyFavoriteResponse: Codable {
    let data: MyFavoriteData
}

struct MyFavoriteData: Codable {
    let items: [MyFavoriteItem]
}

struct MyFavoriteItem: Codable {
    let id: Int
    let rating: Int
    let reviews_count: Int
    let name: String
    let bio: String
    let second_bio: String
    let specialty: String
    let address: String
    let fees: Int
    let waiting_time: Int
    let image: String
    let city: String
    let region: String
    let is_favorited: Bool
}
