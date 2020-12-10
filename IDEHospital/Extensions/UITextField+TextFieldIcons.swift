//
//  UITextField+TextFieldIcons.swift
//  IDEHospital
//
//  Created by Ziad on 12/9/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

extension UITextField {
    func setTextFieldIcons(with leftImage: String) {
        let leftIcon = UIImageView(image: UIImage(named: leftImage))
        leftIcon.frame.size = CGSize(width: 24.6, height: 27.1)
        self.leftViewMode = UITextField.ViewMode.always
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 43, height: self.bounds.height))
        leftIcon.center = leftPadding.center
        leftPadding.addSubview(leftIcon)
        leftPadding.backgroundColor = UIColor(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
        self.leftView = leftPadding
        
        guard self.tag != 5 else { return }
        let rightIcon = UIImageView(image: UIImage(named: "arrow"))
        rightIcon.frame.size = CGSize(width: 20, height: 11.4)
        self.rightViewMode = UITextField.ViewMode.always
        let rightPadding = UIView(frame: leftPadding.frame)
        rightIcon.center = rightPadding.center
        rightPadding.addSubview(rightIcon)
        self.rightView = rightPadding
    }
}
