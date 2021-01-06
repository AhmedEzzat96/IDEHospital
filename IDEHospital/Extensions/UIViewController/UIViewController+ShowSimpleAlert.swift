//
//  UIViewController+ShowSimpleAlert.swift
//  IDEHospital
//
//  Created by Ziad on 12/11/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

extension UIViewController {
    func showSimpleAlert(type: PopUpType, okButtonAction: OkButtonAction = .dismissCurrent, delegate: SuccessOrFailurePopUpOkButtonDelegate? = nil) {
        let successOrFailurePopUpVC = SuccessOrFailurePopUpVC.create(type, okButtonAction: okButtonAction)
        successOrFailurePopUpVC.delegate = delegate
        present(successOrFailurePopUpVC, animated: true)
    }
    
    @objc func switchToHome() {
        let window = AppDelegate.sharedInstance().window
        let homeVC = HomeVC.create()
        let homeNav = UINavigationController(rootViewController: homeVC)
        window?.rootViewController = homeNav
    }
}
