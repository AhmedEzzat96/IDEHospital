//
//  DoctorProfileView.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 03/01/2021.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import UIKit
import Cosmos

class DoctorProfileView: UIView {
    @IBOutlet weak var doctorImgView: UIImageView!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var tabReviewBtn: UIButton!
    @IBOutlet weak var doctorBioLabel: UILabel!
    // Date View Components
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var previousDateBtn: UIButton!
    @IBOutlet weak var nextPageBtn: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bookNowBtn: CustomButton!
    @IBOutlet weak var doctorProfileBtn: UIButton!
    @IBOutlet weak var reviewsBtn: UIButton!
    @IBOutlet weak var reviewsCountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noAppointmentsForDateLabel: UILabel!
    // Scroll View Components
    @IBOutlet weak var doctorDetailsView: UIView!
    @IBOutlet weak var specialtyLabel: UILabel!
    @IBOutlet weak var secondBioLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapBtn: UIButton!
    @IBOutlet weak var waitingTimeLabel: UILabel!
    @IBOutlet weak var feesLabel: UILabel!
    @IBOutlet weak var companiesLabel: UILabel!
    @IBOutlet weak var doctorProfileView: UIView!
    
    // MARK:- Public Methods
    func setup() {
        setupBackground()
        setupDateView()
        setupImgView()
        setupTableView()
        setupButtons()
        setupLabels()
    }
    
    func hideOrShowDoctorDetails(dotorProfileBtn: Bool = true, reviewBtn: Bool = false, doctorView: Bool = false, tableViewHidden: Bool = true) {
        doctorProfileBtn.isSelected = dotorProfileBtn
        reviewsBtn.isSelected = reviewBtn
        doctorDetailsView.isHidden = doctorView
        tableView.isHidden = tableViewHidden
    }
    
    func showDoctorData(item: DoctorData) {
        doctorNameLabel.text = item.name
        doctorBioLabel.text = item.bio
        ratingView.rating = Double(item.rating)
        addressLabel.text = item.address
        feesLabel.text = "\(L10n.examinationFee)\(item.fees) \(L10n.le)"
        waitingTimeLabel.text = "\(L10n.waitingTime)\(item.waiting_time) \(L10n.mins)"
        specialtyLabel.text = item.specialty
        secondBioLabel.text = item.second_bio
        companiesLabel.text = item.companies.map {$0}.compactMap({$0}).joined(separator: ", ")
        doctorImgView.sd_setImage(with: URL(string: item.image), completed: nil)
        reviewsCountLabel.text = "\(item.reviews_count) \(L10n.review)"
        if item.is_favorited {
            favoriteBtn.setImage(Asset.filledHeart.image, for: .normal)
        } else {
            favoriteBtn.setImage(Asset.emptyHeart.image, for: .normal)
        }
    }
    
}
// MARK:- Private Methods
extension DoctorProfileView {
    private func setupDateView() {
        dateView.backgroundColor = ColorName.darkRoyalBlue.color
        doctorProfileView.backgroundColor = ColorName.white.color.withAlphaComponent(0.76)
        setupDateViewButtons()
        setupDoctorView()
        setupCollectionView()
    }
    
    private func setupDateViewButtons() {
        nextPageBtn.setImage(Asset.rightArrowWhite.image, for: .normal)
        nextPageBtn.tintColor = .white
        previousDateBtn.setImage(Asset.leftArrowWhite.image, for: .normal)
        previousDateBtn.tintColor = .white
        setupLabel(label: dateLabel, font: FontFamily.PTSans.bold.font(size: 12))
    }
    
    private func setupDoctorView() {
        setupLabel(label: doctorNameLabel, font: FontFamily.PTSans.bold.font(size: 15))
        setupLabel(label: doctorBioLabel)
        setupRatingView()
    }
    
    private func setupLabels() {
        setupLabel(label: specialtyLabel, color: .black)
        setupLabel(label: secondBioLabel, color: .black)
        setupLabel(label: addressLabel, color: .black)
        setupLabel(label: waitingTimeLabel, color: .black)
        setupLabel(label: feesLabel, color: .black)
        setupLabel(label: companiesLabel, color: .black)
        setupLabel(label: noAppointmentsForDateLabel, font: FontFamily.PTSans.bold.font(size: 15), text: L10n.noAppointments)
    }
    
    private func setupLabel(label: UILabel, color: UIColor = .white, font: UIFont = FontFamily.PTSans.regular.font(size: 12), text: String? = nil) {
        label.text = text
        label.textColor = color
        label.font = font
    }
    
    private func setupButtons() {
        setupCustomButton()
        setupSwitchButton(button: doctorProfileBtn, title: L10n.doctorProfile, notSelected: Asset.rectangle1794.image, selected: Asset.path1565.image)
        setupSwitchButton(button: reviewsBtn, title: L10n.reviews, notSelected: Asset.rectangle1795.image, selected: Asset.path1564.image)
        setupMapBtn()
        setupTabReviewBtn()
    }
    
    private func setupCustomButton() {
        bookNowBtn.isEnabled = false
        bookNowBtn.setTitleColor(UIColor(displayP3Red: 178/255, green: 177/255, blue: 177/255, alpha: 1), for: .disabled)
        bookNowBtn.setTitleColor(.white, for: .normal)
        bookNowBtn.setBackgroundColor(color: ColorName.darkRoyalBlue.color, forState: .normal)
        bookNowBtn.setBackgroundColor(color: ColorName.steelGrey.color, forState: .disabled)
    }
    
    private func setupSwitchButton(button: UIButton, title: String, notSelected: UIImage, selected: UIImage) {
        button.titleLabel?.font = FontFamily.PTSans.bold.font(size: 15)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.black, for: .selected)
        button.setBackgroundImage(notSelected, for: .normal)
        button.setBackgroundImage(selected, for: .selected)
        button.setTitle(title, for: .normal)
        button.setTitle(title, for: .selected)
        button.tintAdjustmentMode = .dimmed
        reviewsCountLabel.textColor = UIColor(displayP3Red: 111/255, green: 4/255, blue: 102/255, alpha: 1)
        reviewsCountLabel.font = FontFamily.PTSans.regular.font(size: 13)
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
    
    private func setupMapBtn() {
        mapBtn.setTitleColor(ColorName.richPurple.color, for: .normal)
        mapBtn.setTitle(L10n.viewOnMap, for: .normal)
        mapBtn.titleLabel?.font = FontFamily.PTSans.regular.font(size: 13)
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 23, bottom: 0, right: 22)
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 25)
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
    }
    
    private func setupTabReviewBtn() {
        let yourAttributes : [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font : FontFamily.PTSans.bold.font(size: 10),
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue.advanced(by: 1)]
               //.styleDouble.rawValue, .styleThick.rawValue, .styleNone.rawValue

        let attributeString = NSMutableAttributedString(string: L10n.tabReview,
                                                          attributes: yourAttributes)
          tabReviewBtn.setAttributedTitle(attributeString, for: .normal)
    }
    
    private func setupTableView() {
        tableView.backgroundColor = ColorName.white.color.withAlphaComponent(0.76)
        tableView.allowsSelection = false
    }
    
    private func setupImgView() {
        doctorImgView.circularImageView()
        doctorImgView.backgroundColor = .white
    }
}
