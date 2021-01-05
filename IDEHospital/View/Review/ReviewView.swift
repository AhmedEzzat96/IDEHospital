//
//  ReviewView.swift
//  IDEHospital
//
//  Created by Ziad on 1/4/21.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import UIKit
import Cosmos

class ReviewView: UIView {

    // MARK:- Outlets
    @IBOutlet weak var rateExperienceLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var submitReviewButton: CustomButton!
    
    // MARK:- LifeCycle Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    // MARK:- Public Methods
    func setup() {
        setupBackground()
        setupRateLabel()
        setupRatingView()
        setupCommentTextField()
        setupSubmitReviewButton()
    }
}

// MARK:- Private Methods
extension ReviewView {
    private func setupRateLabel() {
        rateExperienceLabel.text = L10n.rateInfo
        rateExperienceLabel.font = FontFamily.PTSans.bold.font(size: 14)
        rateExperienceLabel.textColor = ColorName.white.color
    }
    
    private func setupRatingView() {
        ratingView.backgroundColor = .clear
        ratingView.settings.starSize = 15
        ratingView.settings.starMargin = 3
        ratingView.rating = 3
        ratingView.settings.filledImage = Asset.filledStar.image
        ratingView.settings.emptyImage = Asset.emptyStar.image
    }
    
    private func setupCommentTextField() {
        commentTextField.backgroundColor = .clear
        commentTextField.borderStyle = .none
        commentTextField.font = FontFamily.PTSans.bold.font(size: 12)
        commentTextField.textColor = ColorName.white.color
        commentTextField.attributedPlaceholder = NSAttributedString(string: L10n.addComment, attributes: [NSAttributedString.Key.foregroundColor: ColorName.white.color])
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: commentTextField.frame.size.height, width: commentTextField.frame.size.width, height: 1)
        bottomLine.backgroundColor = ColorName.white.color.cgColor
        commentTextField.layer.addSublayer(bottomLine)
    }
    
    private func setupSubmitReviewButton() {
        submitReviewButton.titleLabel?.font = FontFamily.PTSans.bold.font(size: 20)
        submitReviewButton.setTitle(L10n.submitReview, for: .normal)
    }
}
