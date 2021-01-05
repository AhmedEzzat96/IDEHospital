//
//  SearchResultsCell.swift
//  IDEHospital
//
//  Created by Ziad on 12/19/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit
import SDWebImage
import Cosmos

class SearchResultsCell: UITableViewCell {
    
    // MARK:- Outlets
    @IBOutlet weak var doctorImage: UIImageView!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var specialtyLabel: UILabel!
    @IBOutlet weak var secondBioLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var waitingTimeLabel: UILabel!
    @IBOutlet weak var feesLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var bookNowButton: CustomButton!
    
    //MARK:- Properties
    weak var delegate: CellButtonDelegate?
    
    // MARK:- LifeCycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        doctorImage.circularImageView()
        setupRatingView()
        setupLabels()
        setupButton()
        favoriteButton.tintColor = .none
    }
    
    func configure(with item: DoctorResultsResponse) {
        doctorImage.sd_setImage(with: URL(string: item.image), completed: nil)
        doctorNameLabel.text = item.name
        ratingView.rating = Double(item.rating)
        ratingView.text = "\(item.reviewsCount) \(L10n.reviews)"
        specialtyLabel.text = item.specialty
        secondBioLabel.text = item.secondBio
        addressLabel.text = item.address
        waitingTimeLabel.text = "\(L10n.waitingTime)\(item.waitingTime) \(L10n.mins)"
        feesLabel.text = "\(L10n.fees) : \(item.fees) \(L10n.le)"
        if item.isFavorited {
            self.favoriteButton.setImage(Asset.filledHeart.image, for: .normal)
        } else {
            self.favoriteButton.setImage(Asset.emptyHeart.image, for: .normal)
        }
    }
    
    //MARK:- IBActions
    @IBAction func bookNowBtnPressed(_ sender: UIButton) {
        self.delegate?.bookNow(customTableViewCell: self)
    }
    
    @IBAction func addFavoriteBtnPressed(_ sender: UIButton) {
        self.delegate?.addFavorite(customTableViewCell: self)
    }
}


// MARK:- Private Methods
extension SearchResultsCell {
    private func setupRatingView() {
        ratingView.backgroundColor = .clear
        ratingView.settings.filledImage = Asset.filledStar.image
        ratingView.settings.emptyImage = Asset.emptyStar.image
        ratingView.settings.starSize = 15
        ratingView.settings.textFont = FontFamily.PTSans.regular.font(size: 10)
        ratingView.settings.updateOnTouch = false
        ratingView.settings.starMargin = 3
        ratingView.settings.textMargin = 10
        ratingView.settings.fillMode = .precise
        ratingView.settings.textColor = ColorName.white.color
    }
    
    private func setupLabels() {
        doctorNameLabel.font = FontFamily.PTSans.bold.font(size: 15)
        doctorNameLabel.textColor = ColorName.white.color
        specialtyLabel.font = FontFamily.PTSans.bold.font(size: 15)
        specialtyLabel.textColor = ColorName.white.color
        secondBioLabel.font = FontFamily.PTSans.regular.font(size: 12)
        secondBioLabel.textColor = .white
        addressLabel.font = FontFamily.PTSans.regular.font(size: 12)
        addressLabel.textColor = .white
        waitingTimeLabel.font = FontFamily.PTSans.regular.font(size: 12)
        waitingTimeLabel.textColor = .white
        feesLabel.font = FontFamily.PTSans.regular.font(size: 12)
        feesLabel.textColor = .white
    }
    
    private func setupButton() {
        bookNowButton.setTitle(L10n.bookNow, for: .normal)
    }
}
