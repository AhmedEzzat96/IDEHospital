//
//  PaddedTextField.swift
//  IDEHospital
//
//  Created by Ziad on 12/14/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class PaddedTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        self.font = FontFamily.PTSans.regular.font(size: 20)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let rightBounds = CGRect(x: bounds.size.width - 33, y: 17.2, width: 20, height: 11.4)
        return rightBounds
    }

    // MARK:- Public Methods
    func setTextFieldIcons(with leftImage: UIImage) {
        let leftIcon = UIImageView(image: leftImage)
        leftIcon.frame.size = CGSize(width: 24.6, height: 27.1)
        self.leftViewMode = UITextField.ViewMode.always
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 43, height: self.bounds.height))
        leftIcon.center = leftPadding.center
        leftPadding.addSubview(leftIcon)
        leftPadding.backgroundColor = ColorName.darkRoyalBlue.color
        self.leftView = leftPadding
        self.layer.masksToBounds = true
        
        guard self.tag != 5 else { return }
        tintColor = .clear
        let rightIcon = UIImageView(image: Asset.arrow.image)
        self.rightViewMode = .always
        self.rightView = rightIcon
        
    }
}
