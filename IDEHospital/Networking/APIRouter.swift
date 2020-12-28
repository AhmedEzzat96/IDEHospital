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
    case searchForDoctors(_ doctorsFilter: DoctorsFilter)
    case favorites(_ page: Int)
    case addRemoveFavorite(_ doctorID: Int)
    case appointments(_ page: Int)
    case removeAppointment(_ appointmentID: Int)
    case register(_ user: User)
    case login(_ user: User)
    
    // MARK: - HttpMethod
    private var method: HTTPMethod {
        switch self {
        case .getCategoriesData, .mainCategories, .favorites, .appointments, .searchForDoctors:
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
        case .favorites(let page), .appointments(let page):
            return [ParameterKeys.page: page]
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
        case .searchForDoctors(let doctorsFilter):
            return URLs.mainCategories + "/\(doctorsFilter.categoryId!)/doctors"
        case .addRemoveFavorite(let doctorID):
            return URLs.favorites + "/\(doctorID)/add_remove"
        case .appointments:
            return URLs.appointments
        case .removeAppointment(let appointmentID):
            return URLs.appointments + "/\(appointmentID)"
        case .register:
            return URLs.register
        case .login:
            return URLs.login
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
        case .nurseRequest, .register, .login:
            urlRequest.setValue(L10n.en, forHTTPHeaderField: HeaderKeys.acceptLanguage)
            urlRequest.setValue(HeaderValues.appJSON, forHTTPHeaderField: HeaderKeys.accept)
        case .favorites, .addRemoveFavorite, .appointments, .removeAppointment, .searchForDoctors:
            urlRequest.setValue(UserDefaultsManager.shared().token,
                                forHTTPHeaderField: HeaderKeys.authorization)
        default:
            urlRequest.setValue(L10n.en, forHTTPHeaderField: HeaderKeys.acceptLanguage)
        }
        
        
        // HTTP Body
        let httpBody: Data? = {
            switch self {
            case .nurseRequest(let body):
                return encodeToJSON(body)
            case .register(let body):
                return encodeToJSON(body)
            case .login(let body):
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

