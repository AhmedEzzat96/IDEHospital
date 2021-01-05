//
//  ReviewCell.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 04/01/2021.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import UIKit
import Cosmos

class ReviewCell: UITableViewCell {
    // MARK:- IBOutlets
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    
    // MARK:- Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    // MARK:- Public Methods
    func configure(item: ReviewsItem) {
        ratingView.rating = Double(item.rating)
        doctorNameLabel.text = item.commented_by
        reviewLabel.text = item.comment
    }
}

// MARK:- Private Methods
extension ReviewCell {
    private func setup() {
        setupRatingView()
        setupLabel(label: doctorNameLabel, color: ColorName.darkRoyalBlue.color, font: FontFamily.PTSans.bold.font(size: 12))
        setupLabel(label: reviewLabel, color: ColorName.black.color, font: FontFamily.PTSans.regular.font(size: 10))
    }
    
    private func setupRatingView() {
        ratingView.settings.updateOnTouch = false
        ratingView.backgroundColor = .clear
        ratingView.settings.filledImage = Asset.starFilled.image
        ratingView.settings.emptyImage = Asset.starEmpty.image
        ratingView.settings.textFont = FontFamily.PTSans.regular.font(size: 12)
        ratingView.settings.textColor = Color.white
        ratingView.settings.starSize = 15
    }
    
    private func setupLabel(label: UILabel, color: UIColor, font: UIFont) {
        label.font = font
        label.textColor = color
    }
}
