//
//  Constants.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 07/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation

// Storyboards
struct Storyboards {
    static let serviceSearch = "ServiceSearch"
    static let home = "Home"
    static let myFavorites = "MyFavorites"
    static let myAppointments = "MyAppointments"
    
}

// ViewControllers
struct ViewControllers {
    static let serviceSearchVC = "ServiceSearchVC"
    static let homeVC = "HomeVC"
    static let myFavoritesVC = "MyFavoritesVC"
    static let myAppointmentsVC = "MyAppointments"
    
}

// UserDefaultsKeys
struct UserDefaultsKeys {
    static let token = "UDKToken"
}

// Urls
struct URLs {
    static let base = "http://ide-hospital.ideaeg.co/api"
    static let mainCategories = "/main_categories"
}

// HeaderKeys
struct HeaderKeys {
    static let accept = "accept"
    static let acceptLanguage = "Accept-Language"
    static let language = "Accept-Language"
}

// HeaderValues
struct HeaderValues {
    static let appJSON = "application/json"
    static let en = "en"
}

// Parameters Keys
struct ParameterKeys {
    
}

// Cells
struct Cells {
    static let categoryCell = "CategoryCell"
    static let myFavoriteCell = "MyFavoriteCell"
}
