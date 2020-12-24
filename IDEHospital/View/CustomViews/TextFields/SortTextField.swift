//
//  SortTextField.swift
//  IDEHospital
//
//  Created by Ziad on 12/20/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class SortTextField: UITextField {
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.width - 35, y: 11, width: 11.5, height: 6.7)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 32, y: 7, width: 50, height: 14)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = ColorName.darkRoyalBlue.color
        self.borderStyle = .none
        let label = UILabel()
        label.text = L10n.sortBy
        label.font = FontFamily.PTSans.regular.font(size: 12)
        label.textColor = ColorName.white.color
        self.leftViewMode = .always
        self.leftView = label
        let rightArrow = UIImageView(image: Asset.whiteArrow.image)
        self.rightViewMode = .always
        self.rightView = rightArrow
        tintColor = .clear
        self.font = FontFamily.PTSans.regular.font(size: 11)
        self.textColor = ColorName.white.color
    }
}
