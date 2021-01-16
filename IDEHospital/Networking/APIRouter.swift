//
//  APIRouter.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 07/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//


import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible{
    
    // The endpoint name
    case getCategoriesData(_ CategoriesID: Int)
    case mainCategories
    case nurseRequest(_ requestData: RequestData)
    case contactRequest(_ requestData: RequestData)
    case searchForDoctors(_ doctorsFilter: DoctorsFilter)
    case favorites(_ page: Int)
    case addRemoveFavorite(_ doctorID: Int)
    case appointments(_ page: Int)
    case removeAppointment(_ appointmentID: Int)
    case aboutUs
    case terms
    case register(_ user: User)
    case login(_ user: User)
    case forgetPassword(_ user: User)
    case logout
    case addReview(_ review: Review)
    case bookAppointment(_ appointment: Appointment)
    case doctors(_ doctorID: Int)
    case reviews(_ doctorID: Int,_ page: Int)
    case doctorAppointments(_ doctorID: Int)
    case loginAndBook(_ userAndBooking: UserAndBooking)
    case registerAndBook(_ userAndBooking: UserAndBooking)
    
    // MARK: - HttpMethod
    private var method: HTTPMethod {
        switch self {
        case .getCategoriesData, .mainCategories, .favorites, .appointments, .searchForDoctors, .aboutUs, .terms, .doctors, .reviews, .doctorAppointments:
            return .get
        case .removeAppointment:
            return .delete
        default:
            return .post
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .searchForDoctors(let doctorsFilter):
            return doctorsFilter.parameters()
        case .favorites(let page), .appointments(let page), .reviews(_, let page):
            return [ParameterKeys.page: page]
        case .addReview(let review):
            return review.parameters()
        default:
            return nil
        }
    }
    
    // MARK:- Path
    private var path: String {
        switch self {
        case .getCategoriesData(let categoriesID):
            return URLs.mainCategories + "/\(categoriesID)/doctors_query_parameters"
        case .favorites:
            return URLs.favorites
        case .mainCategories:
            return URLs.mainCategories
        case .nurseRequest:
            return URLs.nurseRequset
        case .contactRequest:
            return URLs.contactRequest
        case .searchForDoctors(let doctorsFilter):
            return URLs.mainCategories + "/\(doctorsFilter.categoryId!)/doctors"
        case .addRemoveFavorite(let doctorID):
            return URLs.favorites + "/\(doctorID)/add_remove"
        case .appointments:
            return URLs.appointments
        case .removeAppointment(let appointmentID):
            return URLs.appointments + "/\(appointmentID)"
        case .aboutUs:
            return URLs.aboutUs
        case .terms:
            return URLs.terms
        case .register:
            return URLs.register
        case .login:
            return URLs.login
        case .forgetPassword:
            return URLs.forgetPassword
        case .logout:
            return URLs.logout
        case .addReview(let review):
            return URLs.addReview + "/\(review.doctorID)/reviews"
        case .bookAppointment:
            return URLs.bookAppointment
        case .doctors(let doctorID):
            return URLs.doctor + "/\(doctorID)"
        case .reviews(let doctorID, _):
            return URLs.doctor + "/\(doctorID)" + URLs.review
        case .doctorAppointments(let doctorID):
            return URLs.doctor + "/\(doctorID)" + URLs.doctorAppointments
        case .loginAndBook:
            return URLs.loginAndBook
        case .registerAndBook:
            return URLs.registerAndBook
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try URLs.base.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Headers
        switch self {
        case .nurseRequest, .register, .login, .forgetPassword, .contactRequest, .loginAndBook, .registerAndBook:
            urlRequest.setValue(HeaderValues.appJSON, forHTTPHeaderField: HeaderKeys.accept)
        case .favorites, .addRemoveFavorite, .appointments, .removeAppointment, .searchForDoctors, .logout, .doctors:
            urlRequest.setValue("Bearer \(UserDefaultsManager.shared().token ?? "")",
                forHTTPHeaderField: HeaderKeys.authorization)
        case .bookAppointment, .addReview:
            urlRequest.setValue("Bearer \(UserDefaultsManager.shared().token ?? "")",
                forHTTPHeaderField: HeaderKeys.authorization)
            urlRequest.setValue(HeaderValues.appJSON, forHTTPHeaderField: HeaderKeys.accept)
        default:
            urlRequest.setValue(L10n.en, forHTTPHeaderField: HeaderKeys.acceptLanguage)
        }
        
        // HTTP Body
        let httpBody: Data? = {
            switch self {
            case .nurseRequest(let body), .contactRequest(let body):
                return encodeToJSON(body)
            case .register(let body):
                return encodeToJSON(body)
            case .login(let body):
                return encodeToJSON(body)
            case .forgetPassword(let body):
                return encodeToJSON(body)
            case .bookAppointment(let body):
                return encodeToJSON(body)
            case .registerAndBook(let body), .loginAndBook(let body):
                return encodeToJSON(body)
            default:
                return nil
            }
        }()
        urlRequest.httpBody = httpBody
        
        // Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get :
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    
}

extension APIRouter {
    private func encodeToJSON<T: Encodable>(_ body: T) -> Data? {
        do {
            let anyEncodable = AnyEncodable(body)
            let jsonData = try JSONEncoder().encode(anyEncodable)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString)
            return jsonData
        } catch {
            print(error)
            return nil
        }
    }
}

// type-erasing wrapper
struct AnyEncodable: Encodable {
    private let _encode: (Encoder) throws -> Void
    
    public init<T: Encodable>(_ wrapped: T) {
        _encode = wrapped.encode
    }
    
    func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}

