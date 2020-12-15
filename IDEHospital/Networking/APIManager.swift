//
//  APIManager.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 07/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    class func getCategoriesData(with categoryID: Int, completion: @escaping (Result<CategoryResponse, Error>) -> Void) {
        request(APIRouter.getCategoriesData(categoryID)) { (response) in
            completion(response)
        }
    }
    
    class func mainCategories(completion: @escaping (Result<MainCategoriesResponse,Error>) -> Void) {
        request(APIRouter.mainCategories) { (response) in
            completion(response)
        }
    }
}

extension APIManager{
    // MARK:- The request function to get results in a closure
    private static func request<T: Decodable>(_ urlConvertible: URLRequestConvertible, completion:  @escaping (Result<T, Error>) -> ()) {
        // Trigger the HttpRequest using AlamoFire
        AF.request(urlConvertible).responseDecodable { (response: AFDataResponse<T>) in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        .responseJSON { response in
            switch response.result {
                
            case .failure(let error):
                completion(.failure(error))
            default:
                return
            }
            print(response)
        }
    }
}
