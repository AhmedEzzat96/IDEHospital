//
//  UIButton+CustomButton.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 16/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class CustomButton : UIButton{
    override func awakeFromNib() {
        super.awakeFromNib()
        setTitleColor(UIColor.white, for: .normal)
        layer.cornerRadius = 10
        backgroundColor = ColorName.darkRoyalBlue.color
        titleLabel?.font = FontFamily.PTSans.bold.font(size: 12)
    }
}
