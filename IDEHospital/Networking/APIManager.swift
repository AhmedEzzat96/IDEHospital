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
    
    class func sendNurseRequest(_ requestData: RequestData, completion: @escaping (Result<Bool, Error>) -> Void) {
        AF.upload(multipartFormData: { (multiPartFormData) in
            multiPartFormData.append(Data(requestData.0!.utf8), withName: "name")
            multiPartFormData.append(Data(requestData.1!.utf8), withName: "email")
            multiPartFormData.append(Data(requestData.2!.utf8), withName: "mobile")
            multiPartFormData.append(Data(requestData.3!.utf8), withName: "message")
        }, with: APIRouter.nurseRequest).response { response in
            switch response.result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
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
