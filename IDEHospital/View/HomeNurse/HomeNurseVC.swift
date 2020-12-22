//
//  HomeNurseVC.swift
//  IDEHospital
//
//  Created by Ziad on 12/16/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

protocol HomeNurseVCProtocol: class {
    func addPlaceholder()
    func showAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)?)
    func showLoader()
    func hideLoader()
    func showHomeVC()
}

class HomeNurseVC: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var mainView: HomeNurseView!
    
    // MARK:- Properties
    private var viewModel: HomeNurseViewModelProtocol!
    
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        mainView.setup()
        mainView.detailsTextView.delegate = self
    }

    //MARK:- Public Methods
    class func create() -> HomeNurseVC {
        let homeNurseVC: HomeNurseVC = UIViewController.create(storyboardName: Storyboards.homeNurse, identifier: ViewControllers.homeNurseVC)
        homeNurseVC.viewModel = HomeNurseViewModel(view: homeNurseVC)
        return homeNurseVC
    }
    
    // MARK:- Actions
    @IBAction func sendRequestButtonPressed(_ sender: UIButton) {
        viewModel.requestTapped(with: RequestData(name: mainView.nameTextField.text, email: mainView.emailTextField.text, mobile: mainView.phoneTextField.text, message: mainView.detailsTextView.text))
    }
}
extension HomeNurseVC {
// MARK:- Private Methods
    private func setupNavigationItems() {
        title = L10n.homeNurse
        let backItem = UIBarButtonItem(image: Asset.back.image, style: .done, target: self, action: #selector(popUp))
        backItem.tintColor = ColorName.steelGrey.color
        let leftPadding = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        leftPadding.width = 18
        navigationItem.leftBarButtonItems = [leftPadding, backItem]
        let settingsItem = UIBarButtonItem(image: Asset.settings.image, style: .done, target: self, action: #selector(showSettings))
        settingsItem.tintColor = ColorName.steelGrey.color
        let rightPadding = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        rightPadding.width = 18
        navigationItem.rightBarButtonItems = [rightPadding, settingsItem]
    }
    
    // MARK:- Objc Methods
    @objc private func popUp() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func showSettings() {
        print("Show Settings")
    }
}

// MARK:- TextView Delegate
extension HomeNurseVC: UITextViewDelegate {
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
extension HomeNurseVC: HomeNurseVCProtocol {
    func addPlaceholder() {
        DispatchQueue.main.async {
            self.mainView.detailsTextView.text = "Enter Details"
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
        popUp()
    }
}
