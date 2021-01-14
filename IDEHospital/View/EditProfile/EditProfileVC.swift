//
//  EditProfileVC.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 09/01/2021.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import UIKit

protocol EditProfileVCProtocol: class {
    func showAlert(_ type: PopUpType, okButtonAction: OkButtonAction)
    func showLoader()
    func hideLoader()
    func showUserData(with user: AuthData)
}

class EditProfileVC: UIViewController {
    // MARK:- IBOutlets
    @IBOutlet weak var editProfileView: EditProfileView!
    
    // MARK:- Properties
    private var viewModel: EditProfileViewModelProtocol!
    
    // MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavController(title: L10n.editProfileNav)
        editProfileView.setup()
        viewModel.getUserData()
    }
    
    // MARK:- Public Methods
    class func create() -> EditProfileVC {
        let editProfileVC: EditProfileVC = UIViewController.create(storyboardName: Storyboards.editProfile, identifier: ViewControllers.editProfileVC)
        editProfileVC.viewModel = EditProfileViewModel(view: editProfileVC)
        return editProfileVC
    }
    
    // MARK:- IBActions
    @IBAction func saveBtnPressed(_ sender: CustomButton) {
        self.viewModel.editUserData(name: editProfileView.nameTextField.text, email: editProfileView.emailTextField.text, mobileNo: editProfileView.mobileNoTextField.text, oldPassword: editProfileView.oldPasswordTextField.text, newPassword: editProfileView.newPasswordTextField.text, confirmPassword: editProfileView.confirmPasswordTextField.text)
    }
    
    @IBAction func cancelBtnPressed(_ sender: CustomButton) {
        self.dismissCurrent()
    }
    
}

// MARK:- Private Methods
extension EditProfileVC {
    
}

// MARK:- EditProfileVC Protocol
extension EditProfileVC: EditProfileVCProtocol {
    func showAlert(_ type: PopUpType, okButtonAction: OkButtonAction) {
        self.showSimpleAlert(type: type, okButtonAction: okButtonAction, delegate: self)
    }
    
    func showLoader() {
        self.view.showActivityIndicator()
    }
    
    func hideLoader() {
        self.view.hideActivityIndicator()
    }
    
    func showUserData(with user: AuthData) {
        self.editProfileView.showData(with: user)
    }
}

// MARK:- SuccessOrFailure Delegate
extension EditProfileVC: SuccessOrFailurePopUpOkButtonDelegate {
    func okTapped() {
        self.dismissCurrent()
    }
}
