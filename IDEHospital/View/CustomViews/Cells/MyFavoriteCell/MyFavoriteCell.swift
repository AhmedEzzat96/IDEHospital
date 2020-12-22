//
//  MyFavoriteCell.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 15/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit
import Cosmos

protocol CellButtonDelegate: class {
    func showDeleteAlert(customTableViewCell: UITableViewCell)
    func viewProfileAlert(customTableViewCell: UITableViewCell)
    func viewOnMap(customTableViewCell: UITableViewCell)
    func bookNowAlert(customTableViewCell: UITableViewCell)
    func addFavorite(customTableViewCell: UITableViewCell)
}

class MyFavoriteCell: UITableViewCell {
    //MARK:- IBOutlets
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
    @IBOutlet var deleteBtn: UIButton!
    @IBOutlet var viewProfileBtn: CustomButton!
    @IBOutlet weak var ratingView: CosmosView!
    
    //MARK:- Properties
    private var viewModel: MyFavoriteCellViewModelProtocol!
    weak var delegate: CellButtonDelegate?
    
    //MARK:- Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewModel = MyFavoriteCellViewModel()
        setup()
    }
    
    //MARK:- Public Methods
    func configureCell(_ item: MyFavoriteItem) {
        self.doctorNameLabel.text = item.name
        self.specialtyLabel.text = item.specialty
        self.secondBioLabel.text = item.second_bio
        self.adressLabel.text = item.address
        self.waitingTimeLabel.text = "\(L10n.waitingTime)\(item.waiting_time) \(L10n.mins)"
        self.feesLabel.text = "\(L10n.examinationFee)\(item.fees) \(L10n.le)"
        self.ratingView.text = "\(item.reviews_count) \(L10n.review)"
        self.ratingView.rating = Double(item.rating)
        viewModel.downloadImage(with: item) { (image) in
            self.doctorImgView.image = image
        }
    }
    
    //MARK:- IBActions
    @IBAction func deleteBtnPressed(_ sender: UIButton) {
        self.delegate?.showDeleteAlert(customTableViewCell: self)
    }
    
    @IBAction func viewProfileBtnPressed(_ sender: CustomButton) {
        self.delegate?.viewProfileAlert(customTableViewCell: self)
    }
    
    
}

//MARK:- Private Methods
extension MyFavoriteCell {
    private func setup() {
        setupRatingView()
        setupImgView()
        setupButton()
        setupLabel(doctorNameLabel, font: FontFamily.PTSans.bold.font(size: 15))
        setupLabel(specialtyLabel, font: FontFamily.PTSans.bold.font(size: 15))
        setupLabel(secondBioLabel)
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
        ratingView.settings.starSize = 15
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
        deleteBtn.setImage(Asset.cancelBtn.image, for: .normal)
        deleteBtn.tintColor = .white
        viewProfileBtn.setTitle(L10n.viewProfile, for: .normal)
    }
}

extension CellButtonDelegate {
    func showDeleteAlert(customTableViewCell: UITableViewCell){
        
    }
    
    func viewProfileAlert(customTableViewCell: UITableViewCell) {
        
    }
    
    func viewOnMap(customTableViewCell: UITableViewCell){

    }
    
    func bookNowAlert(customTableViewCell: UITableViewCell) {
        
    }
    
    func addFavorite(customTableViewCell: UITableViewCell) {
        
    }
}
