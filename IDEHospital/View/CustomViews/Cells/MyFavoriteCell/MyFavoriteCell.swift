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
    @IBOutlet var feesLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupRatingView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
}

extension MyFavoriteCell {
    private func setupRatingView() {
        ratingView.settings.updateOnTouch = false
        ratingView.backgroundColor = .clear
//        ratingView.settings.filledImage = Asset
//        ratingView.settings.emptyImage =
    }
}

extension MyFavoriteCell: MyFavoriteCellProtocol {
    
}
