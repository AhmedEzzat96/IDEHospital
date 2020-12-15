//
//  PaddedTextField.swift
//  IDEHospital
//
//  Created by Ziad on 12/14/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class PaddedTextField: UITextField {
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let rightBounds = CGRect(x: bounds.size.width - 33, y: 17.2, width: 20, height: 11.4)
        return rightBounds
    }

}
