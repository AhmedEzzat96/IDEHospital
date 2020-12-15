//
//  UITextField+TextFieldIcons.swift
//  IDEHospital
//
//  Created by Ziad on 12/9/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

extension UITextField {
    func setTextFieldIcons(with leftImage: UIImage) {
        let leftIcon = UIImageView(image: leftImage)
        leftIcon.frame.size = CGSize(width: 24.6, height: 27.1)
        self.leftViewMode = UITextField.ViewMode.always
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 43, height: self.bounds.height))
        leftIcon.center = leftPadding.center
        leftPadding.addSubview(leftIcon)
        leftPadding.backgroundColor = ColorName.darkRoyalBlue.color
        self.leftView = leftPadding
        
        guard self.tag != 5 else { return }
        let rightIcon = UIImageView(image: Asset.arrow.image)
        rightIcon.frame.size = CGSize(width: 20, height: 11.4)
        self.rightViewMode = .always
        self.rightView = rightIcon
    }
}
