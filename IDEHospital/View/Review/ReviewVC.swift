//
//  ReviewVC.swift
//  IDEHospital
//
//  Created by Ziad on 1/4/21.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import UIKit

protocol ReviewVCProtocol: class {
    func showLoader()
    func hideLoader()
    func showAlert(type: PopUpType)
}

class ReviewVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var mainView: ReviewView!
    
    // MARK:- Properties
    private var viewModel: ReviewViewModelProtocol!
    
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        mainView.setup()
    }
    
    // MARK:- Public Methods
    class func create(for doctorID: Int) -> ReviewVC {
        let reviewVC: ReviewVC = UIViewController.create(storyboardName: Storyboards.review, identifier: ViewControllers.reviewVC)
        reviewVC.viewModel = ReviewViewModel(view: reviewVC, doctorID: doctorID)
        return reviewVC
    }
    
    // MARK:- Actions
    @IBAction func submitReviewButtonPressed(_ sender: UIButton) {
        viewModel.submitReviewTapped(rating: mainView.ratingView.rating, comment: mainView.commentTextField.text)
    }
}

// MARK:- Private Methods
extension ReviewVC {
    private func setupNavigationController() {
        setupNavController(title: L10n.review)
        setupNavigationItems(backAction: .popUpCurrent)
    }
}

// MARK:- ReviewVC Protocol
extension ReviewVC: ReviewVCProtocol {
    func showLoader() {
        view.showActivityIndicator()
    }
    
    func hideLoader() {
        view.hideActivityIndicator()
    }
    
    func showAlert(type: PopUpType) {
        showSimpleAlert(type: type)
    }
}
