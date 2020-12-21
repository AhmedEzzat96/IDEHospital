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
    
    // MARK: - HttpMethod
    private var method: HTTPMethod {
        switch self{
        case .getCategoriesData, .mainCategories, .favorites:
            return .get
        default:
            return .post
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .favorites(let page):
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
        case .favorites, .addRemoveFavorite:
            urlRequest.setValue("Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiZWRiYTk2NTg5NGIzY2NmYmRhMTE3YWI1ZTI0MmQxZjYzZDYwN2FjZDg3YWRhYzAzZjkyYmVmM2I5ZmYxNmNkZTk0YzllYmVhMTRiNDBlMmUiLCJpYXQiOjE2MDgzMjUzNzAsIm5iZiI6MTYwODMyNTM3MCwiZXhwIjoxNjM5ODYxMzcwLCJzdWIiOiI0OCIsInNjb3BlcyI6W119.XZm8XM6K7pSpTk-E84_aFchYffe4u-Gj2fNVKBovN8pDAi23WJtnBDmTN46F_ssp_zgEuqZriH-hP6LQy22W_m2MPy3lhZrI0Codlqe1OmRkbXuRQ_n-jeZZHLEE0stXy2bWKxdXsJr5kCnc5Mapy6aikW3rLu-tboRLTbrc7g73W6pYECNNhgyz7lzuXiEpgdzko7_G8tg6zICjPyhoAchTBdyVXlzd70hxv8k3UCCnJEwlxTfJPQ1CbwzHo_AAYsp55-j66N4HGoLYVipnppXthxM-KEKCuoyrV9JaZXnRIy3qgOGTkGVgXwOV-ZLShWRpGft3w9UlB0wwif5A6lYt7CT_JKwlB_uB1vvPzgJYFHPUaTTEqIYKdEuFGnsA6cdFBtn8u2LvvIoi8s-QBP4QmJSA3QmkJ-Ocxnw7oI1llez9vP5wQBu2d3_QjVlAteg_rJpBX9xWd77-ipJ-5HvHxnXPWl4CzFK-HTcxzno0xQ_O-LUpYnWHMofnGLlrm7TfrVJ8uVrx-uVs3GWRMLo4SIeLEgXk6j9mSzBzV6AHE1Bm4Ct2KH1i-nIsXHUcuUl39Mil-8BoViCSkg1Ys9Aqh3Ko7krpBAcpuKXGINmupkpvf-5vvyymBc4APCL4Sh311OA5lMmeBBncuBPEMJ-w1wm1dgfePZ2ccPiPmcU",
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

