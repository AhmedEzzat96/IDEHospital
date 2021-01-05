//
//  ReviewViewModel.swift
//  IDEHospital
//
//  Created by Ziad on 1/4/21.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import Foundation

protocol ReviewViewModelProtocol {
    func submitReviewTapped(rating: Double, comment: String?)
}

class ReviewViewModel {
    
    // MARK:- Properties
    private weak var view: ReviewVCProtocol?
    private var review: Review!
    
    // MARK:- Init
    init(view: ReviewVCProtocol, doctorID: Int) {
        self.view = view
        self.review = Review(doctorID: doctorID)
    }
}

// MARK:- Private Methods
extension ReviewViewModel {
    private func addReview() {
        APIManager.addReview(review) { [weak self] (result) in
            switch result {
            case .success(let response):
                if response.success, response.code == 202 {
                    self?.view?.showAlert(title: L10n.done, message: "Your review submitted succesfully")
                }
            case .failure(let error):
                print(error)
                self?.view?.showAlert(title: L10n.sorry, message: error.localizedDescription)
            }
        }
    }
}

// MARK:- ViewModel Protocol
extension ReviewViewModel: ReviewViewModelProtocol {
    func submitReviewTapped(rating: Double, comment: String?) {
        if let commentError = ValidationManager.shared().isValidData(with: .reviewComment(comment)) {
            view?.showAlert(title: L10n.sorry, message: commentError)
        } else {
            review.rating = Int(rating)
            review.comment = comment
            addReview()
        }
    }
}
