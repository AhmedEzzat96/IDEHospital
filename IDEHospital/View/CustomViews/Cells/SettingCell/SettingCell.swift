//
//  SettingCell.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 28/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {
    //MARK:- IBOutlets
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK:- Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    //MARK:- Public Methods
    func configure(data: Setting) {
        imgView.image = data.icon
        titleLabel.text = data.title
    }
}

//MARK:- Private Methods
extension SettingCell {
    private func setup() {
        self.backgroundColor = .clear
        self.accessoryView = UIImageView(image: Asset.back2.image)
        setupLabel()
    }
    
    private func setupLabel() {
        titleLabel.font = FontFamily.PTSans.regular.font(size: 20)
        titleLabel.textAlignment = .left
        titleLabel.textColor = ColorName.darkRoyalBlue.color
    }
}
