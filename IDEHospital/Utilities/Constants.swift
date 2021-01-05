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
    static let homeNurse = "HomeNurseContactUs"
    static let searchResults = "SearchResults"
    static let myFavorites = "MyFavorites"
    static let myAppointments = "MyAppointments"
    static let aboutAndTerms = "AboutAndTerms"
    static let authentication = "Authentication"
    static let setting = "Setting"
    static let doctorProfile = "DoctorProfile"
}

// ViewControllers
struct ViewControllers {
    static let serviceSearchVC = "ServiceSearchVC"
    static let homeVC = "HomeVC"
    static let homeNurseContactUsVC = "HomeNurseContactUsVC"
    static let searchResultsVC = "SearchResultsVC"
    static let myFavoritesVC = "MyFavoritesVC"
    static let myAppointmentsVC = "MyAppointmentsVC"
    static let aboutAndTerms = "AboutAndTermsVC"
    static let loginVC = "LoginVC"
    static let signupVC = "SignupVC"
    static let resetPasswordVC = "ResetPasswordVC"
    static let settingVC = "SettingVC"
    static let doctorProfileVC = "DoctorProfileVC"
}

// UserDefaultsKeys
struct UserDefaultsKeys {
    static let token = "UDKToken"
}

// Urls
struct URLs {
    static let base = "http://ide-hospital.ideaeg.co/api"
    static let mainCategories = "/main_categories"
    static let nurseRequset = "/nursing_requests"
    static let contactRequest = "/contact_us_requests"
    static let favorites = "/favorites/doctors"
    static let appointments = "/user_appointments"
    static let aboutUs = "/about_us"
    static let terms = "/terms_and_conditions"
    static let register = "/register"
    static let login = "/login"
    static let forgetPassword = "/forget_password"
    static let logout = "/logout"
    static let doctor = "/doctors"
    static let review = "/reviews"
    static let doctorAppointments = "/appointments"
}

// HeaderKeys
struct HeaderKeys {
    static let accept = "Content-Type"
    static let acceptLanguage = "Accept-Language"
    static let authorization = "Authorization"
}

// HeaderValues
struct HeaderValues {
    static let appJSON = "application/json"
    static let en = "en"
}

// Parameters Keys
struct ParameterKeys {
    static let name = "name"
    static let email = "email"
    static let mobile = "mobile"
    static let message = "message"
    static let mainCategoryId = "main_category_id"
    static let page = "page"
    static let specialtyId = "specialty_id"
    static let cityId = "city_id"
    static let regionId = "region_id"
    static let companyId = "company_id"
    static let orderBy = "order_by"
}

// Cells
struct Cells {
    static let categoryCell = "CategoryCell"
    static let searchResultsCell = "SearchResultsCell"
    static let myFavoriteCell = "MyFavoriteCell"
    static let myAppointmentCell = "MyAppointmentCell"
    static let settingCell = "SettingCell"
    static let timeCell = "TimeCell"
    static let reviewCell = "ReviewCell"
}
