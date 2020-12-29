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
    
    class func mainCategories(completion: @escaping (Result<MainCategoriesResponse, Error>) -> Void) {
        request(APIRouter.mainCategories) { (response) in
            completion(response)
        }
    }
    
    class func sendRequest(_ nurseOrContactRequest: URLRequestConvertible, completion: @escaping (Result<RequestResponse, Error>) -> Void) {
        request(nurseOrContactRequest) { (response) in
            completion(response)
        }
    }
    
    class func addRemoveFavorite(with doctorID: Int, completion: @escaping (Bool) -> Void) {
        requestBool(APIRouter.addRemoveFavorite(doctorID)) { (response) in
            completion(response)
        }
    }
    
    class func searchForDoctors(with doctorsFilter: DoctorsFilter, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
        request(APIRouter.searchForDoctors(doctorsFilter)) { (response) in
            completion(response)
        }
    }
    
    class func favorites(for page: Int, completion: @escaping (Result<MyFavoriteResponse, Error>) -> Void) {
        request(APIRouter.favorites(page)) { (response) in
            completion(response)
        }
    }
    
    class func appointments(for page: Int, completion: @escaping (Result<MyAppointmentResponse, Error>) -> Void) {
        request(APIRouter.appointments(page)) { (response) in
            completion(response)
        }
    }
    
    class func removeAppointment(with appointmentID: Int, completion: @escaping (Bool) -> Void) {
        requestBool(APIRouter.removeAppointment(appointmentID)) { (response) in
            completion(response)
        }
    }
    
    class func getAboutOrTerms(_ aboutOrTermsRequest: URLRequestConvertible, completion: @escaping (Result<AboutAndTermsResponse, Error>) -> Void) {
        request(aboutOrTermsRequest) { (response) in
            completion(response)
        }
    }
    
    class func register(with user: User, completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        request(APIRouter.register(user)) { (response) in
            completion(response)
        }
    }
    
    class func login(with user: User, completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        request(APIRouter.login(user)) { (response) in
            completion(response)
        }
    }
    
    class func forgetPassword(with user: User, completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        request(APIRouter.forgetPassword(user)) { (response) in
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
    
    // MARK:- The request function to get results in Bool
    private static func requestBool(_ urlConvertible: URLRequestConvertible, completion:  @escaping (Bool) -> ()) {
        // Trigger the HttpRequest using AlamoFire
        AF.request(urlConvertible).response { (response) in
            switch response.result {
            case .success(_):
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
    }
}
