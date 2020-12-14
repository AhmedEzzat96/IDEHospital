//
//  CategoryCell.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 10/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit
import SDWebImage

class CategoryCell: UICollectionViewCell {
    //MARK:- IBOutlets
    @IBOutlet weak var categoryImgView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    //MARK:- Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setupLabel()
        setupImage()
    }
    
    //MARK:- Public Methods
    func configure(_ category: MainCategoriesData) {
        categoryLabel.text = category.name
        backgroundColor = UIColor.init(hexString: category.color)
        categoryImgView.sd_setImage(with: URL(string: category.image), completed: nil)
    }
    
}

//MARK:- Private Methods
extension CategoryCell {
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
