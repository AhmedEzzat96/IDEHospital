//
//  HomeNurseVC.swift
//  IDEHospital
//
//  Created by Ziad on 12/16/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

protocol HomeNurseContactUsVCProtocol: class {
    func addPlaceholder()
    func showAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)?)
    func showLoader()
    func hideLoader()
    func showHomeVC()
}

enum Status {
    case homeNurse
    case contactUs
}

class HomeNurseContactUsVC: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var mainView: HomeNurseContactUsView!
    
    // MARK:- Properties
    private var viewModel: HomeNurseContactUsViewModelProtocol!
    
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        mainView.setup(buttonTitle: viewModel.getTitles().1, isNumberLabelHidden: viewModel.isNumberLabelHidden())
        mainView.detailsTextView.delegate = self
    }

    //MARK:- Public Methods
    class func create(status: Status) -> HomeNurseContactUsVC {
        let homeNurseContactUsVC: HomeNurseContactUsVC = UIViewController.create(storyboardName: Storyboards.homeNurse, identifier: ViewControllers.homeNurseContactUsVC)
        homeNurseContactUsVC.viewModel = HomeNurseViewModel(view: homeNurseContactUsVC, status: status)
        return homeNurseContactUsVC
    }
    
    // MARK:- Actions
    @IBAction func sendRequestButtonPressed(_ sender: UIButton) {
        viewModel.requestTapped(with: RequestData(name: mainView.nameTextField.text, email: mainView.emailTextField.text, mobile: mainView.phoneTextField.text, message: mainView.detailsTextView.text))
    }
}

// MARK:- Private Methods
extension HomeNurseContactUsVC {
    private func setupNavigationController() {
        title = viewModel.getTitles().0
        setupNavigationItems(backAction: .popUpCurrent)
    }
}

// MARK:- TextView Delegate
extension HomeNurseContactUsVC: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        DispatchQueue.main.async {
            textView.text = ""
        }
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        viewModel.textViewShouldEndEditing(text: textView.text)
        return true
    }
}

// MARK:- HomeNurseVC Protocol
extension HomeNurseContactUsVC: HomeNurseContactUsVCProtocol {
    func addPlaceholder() {
        DispatchQueue.main.async {
            self.mainView.detailsTextView.text = L10n.enterDetails
        }
    }
    
    func showAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)?) {
        showSimpleAlert(title: title, message: message, handler: handler)
    }
    
    func showLoader() {
        view.showActivityIndicator()
    }
    
    func hideLoader() {
        view.hideActivityIndicator()
    }
    
    func showHomeVC() {
        popUpCurrent()
    }
}
