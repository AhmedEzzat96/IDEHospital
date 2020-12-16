//
//  MyFavoriteCell.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 15/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit
import Cosmos

protocol MyFavoriteCellProtocol: class {
    
}

class MyFavoriteCell: UITableViewCell {
    @IBOutlet var doctorImgView: UIImageView!
    @IBOutlet var doctorNameImgView: UIImageView!
    @IBOutlet var addressImgView: UIImageView!
    @IBOutlet var feesImgView: UIImageView!
    @IBOutlet var waitingTimeImgView: UIImageView!
    @IBOutlet var doctorNameLabel: UILabel!
    @IBOutlet var secondBioLabel: UILabel!
    @IBOutlet var specialtyLabel: UILabel!
    @IBOutlet var adressLabel: UILabel!
    @IBOutlet var waitingTimeLabel: UILabel!
    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet var feesLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func cancelBtnPressed(_ sender: UIButton) {
    }
    
    
}

extension MyFavoriteCell {
    private func setup() {
        setupRatingView()
        setupImgView()
        setupButton()
        setupLabel(doctorNameLabel, font: FontFamily.PTSans.bold.font(size: 15))
        setupLabel(secondBioLabel, font: FontFamily.PTSans.bold.font(size: 15))
        setupLabel(specialtyLabel)
        setupLabel(adressLabel)
        setupLabel(waitingTimeLabel)
        setupLabel(feesLabel)
    }
    private func setupRatingView() {
        ratingView.settings.updateOnTouch = false
        ratingView.backgroundColor = .clear
        ratingView.settings.filledImage = Asset.starFilled.image
        ratingView.settings.emptyImage = Asset.starEmpty.image
        ratingView.settings.textFont = FontFamily.PTSans.regular.font(size: 12)
        ratingView.settings.textColor = Color.white
    }
    
    private func setupImgView() {
        doctorNameImgView.image = Asset.specialtyImg.image
        waitingTimeImgView.image = Asset.waitingTimeImg.image
        feesImgView.image = Asset.feeImg.image
        addressImgView.image = Asset.cellPin.image
        doctorImgView.circularImageView()
        doctorImgView.backgroundColor = .white
    }
    
    private func setupLabel(_ label: UILabel, font: UIFont = FontFamily.PTSans.regular.font(size: 12)) {
        label.textAlignment = .left
        label.textColor = .white
        label.font = font
    }
    
    private func setupButton() {
        cancelBtn.setImage(Asset.cancelBtn.image, for: .normal)
        cancelBtn.tintColor = .white
    }
}

extension MyFavoriteCell: MyFavoriteCellProtocol {
    
}
