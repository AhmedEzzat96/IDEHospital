//
//  CustomScrollView.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 30/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class CustomScrollView: UIScrollView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isDragging {
            self.endEditing(true)
//            next?.touchesBegan(touches, with: event)
        } else {
            super.touchesBegan(touches, with: event)
        }
    }
}
