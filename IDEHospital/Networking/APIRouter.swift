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
    
    // MARK: - HttpMethod
    private var method: HTTPMethod {
        switch self{
        case .getCategoriesData:
            return .get
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        default:
            return nil
        }
    }
    
    // MARK:- Path
    private var path: String {
        switch self {
        case .getCategoriesData(let categoriesID):
            return URLs.categoriesData + "/\(categoriesID)/doctors_query_parameters"
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
        case .getCategoriesData:
            urlRequest.setValue(HeaderValues.en, forHTTPHeaderField: HeaderKeys.language)
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
                return JSONEncoding.default
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

