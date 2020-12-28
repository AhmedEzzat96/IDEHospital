//
//  UIViewController+ShowSimpleAlert.swift
//  IDEHospital
//
//  Created by Ziad on 12/11/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

extension UIViewController {
    func showSimpleAlert(title: String, message: String?, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: L10n.ok, style: .cancel, handler: handler))
        present(alert, animated: true)
    }
}
