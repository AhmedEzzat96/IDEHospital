//
//  AboutUsAndTerms.swift
//  IDEHospital
//
//  Created by Ziad on 12/28/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation

struct AboutAndTermsResponse: Codable {
    let success: Bool
    let code: Int
    let data: AboutAndTerms?
}

struct AboutAndTerms: Codable {
    let aboutUs: String?
    let terms: String?
    
    enum CodingKeys: String, CodingKey {
        case aboutUs = "about_us"
        case terms = "terms_and_conditions"
    }
}
