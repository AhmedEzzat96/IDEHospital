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
    case favorites(_ page: Int)
    case addRemoveFavorite(_ doctorID: Int)
    case appointments(_ page: Int)
    
    // MARK: - HttpMethod
    private var method: HTTPMethod {
        switch self{
        case .getCategoriesData, .mainCategories, .favorites, .appointments:
            return .get
        default:
            return .post
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
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
        case .addRemoveFavorite(let doctorID):
            return URLs.favorites + "/\(doctorID)/add_remove"
        case .appointments:
            return URLs.appointments
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
        case .favorites, .addRemoveFavorite, .appointments:
            urlRequest.setValue("Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMWE4OTQ3YTEwMTM0ODIyM2ZjZDYyYzg0OGFkZDdlMmZmYzhiMzllZDAwMjdiODU4MzE3M2RiMjA2YmM0MmYzMjUyMjQzYmNkNjQ2YzUwZmYiLCJpYXQiOjE2MDQ0OTMzNDMsIm5iZiI6MTYwNDQ5MzM0MywiZXhwIjoxNjM2MDI5MzQzLCJzdWIiOiI0NSIsInNjb3BlcyI6W119.iYhEyw4yRfd5UNhmzR9F2xzhIYZktHEKT_vKXaaiBgEGx1bQ-oyiEq0nC5dYrJGCirPK86J4MNg-yHidl1wpLEeRUE-YROerT5irXwJkEP9dWVsosIItvMdG0msv4w7G4m3wZVSpaVaaJk2y-6KqZ1BphmuDieNqx4xQqHW1Y8NAu3Dh09lMX6xzMKZwu8kB_MEzv7G10b8n5VwktV31eu8MrBDJhZmwriP2MVM8NVKIgbCdAq3o-xThbqmG479ViS1O3ijJ047ZjkkduZsQuh92NHhrkj2wj5UBpjlYEjLlcKwFvFJcQFA5A0B_ackIJLQktDfw9DGFLLOGEzoi2nVj8tINCG9TbI4-5Y-G8h8kMJCzxybNl1UA-LsMoonM3rY3smQdentBVyM53FYkAbgy9yqAl7Od6A-3D2baEZncCHHq2sZe8eUdS_X07qrOEj1Ip-pc5kLwzwD6vM5y8ptFG_sWmszJo1rNOV6ZoacKD0p_KZU21c9DPjei4VP5Y6y_tilEDxLKfK3wCD_80fmhKjAR5BVpRqHmlWnA1laGx0hGxthXHeg6-5URONR4h0Yiw-ZhzxehIrRmG6vDsofg9jeqSbO4WnTTysCd21xhK1gEvj67DgwwY4Tq_iaZDgRQvKzjRDJpGMysFOS6f4MfbQDAwms7X3EyxmfJk_I",
            forHTTPHeaderField: HeaderKeys.authorization)
        default:
            urlRequest.setValue(L10n.en, forHTTPHeaderField: HeaderKeys.acceptLanguage)
        }
        
        // HTTP Body
        let httpBody: Data? = {
            switch self {
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

