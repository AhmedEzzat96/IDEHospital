//
//  CategoryCell.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 10/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    @IBOutlet weak var categoryImgView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setupLabel()
        setupImage()
    }
    
    private func setupView() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
    }
    
    private func setupLabel() {
        categoryLabel.font = FontFamily.PTSans.bold.font(size: 15)
        categoryLabel.textColor = .white
        categoryLabel.textAlignment = .center
    }
    
    private func setupImage() {
        categoryImgView.contentMode = .scaleAspectFit
    }

}
