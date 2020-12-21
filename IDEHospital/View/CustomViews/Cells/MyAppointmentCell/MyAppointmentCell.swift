//
//  MyAppointmentCell.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 21/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit
import Cosmos

class MyAppointmentCell: UITableViewCell {
    //MARK:- IBOutlets
    @IBOutlet weak var doctorImgView: UIImageView!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var mapBtn: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    //MARK:- Properties
    var viewModel: MyAppointmentCellViewModelProtocol!
    weak var delegate: CellButtonDelegate?
    
    //MARK:- Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewModel = MyAppointmentCellViewModel()
        setup()
    }

    //MARK:- Public Methods
    func configureCell(_ item: MyAppointmentItem) {
        self.doctorNameLabel.text = item.doctor.name
        self.ratingView.text = "\(item.doctor.reviews_count) Review"
        self.ratingView.rating = Double(item.doctor.rating)
        self.bioLabel.text = item.doctor.bio
        self.dateLabel.text = viewModel.createDate(timestamp: item.appointment)
        self.timeLabel.text = viewModel.createTime(timestamp: item.appointment)
        viewModel.downloadImage(with: item) { (image) in
            self.doctorImgView.image = image
        }
    }
    
    //MARK:- IBActions
    @IBAction func mapBtnPressed(_ sender: UIButton) {
        delegate?.viewOnMap(customTableViewCell: self)
    }
    
    @IBAction func deleteBtnPressed(_ sender: UIButton) {
        delegate?.showDeleteAlert(customTableViewCell: self)
    }
    
}

//MARK:- Private Methods
extension MyAppointmentCell {
    private func setup() {
        setupBtn()
        setupLabel(label: doctorNameLabel, font: FontFamily.PTSans.bold.font(size: 15))
        setupLabel(label: bioLabel, font: FontFamily.PTSans.regular.font(size: 12))
        setupLabel(label: dateLabel)
        setupLabel(label: timeLabel)
        setupRatingView()
        doctorNameLabel.text = "Dr. Mohamed Yehia"
        setupImgView()
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
    
    private func setupBtn() {
        mapBtn.setTitle("View on map", for: .normal)
        mapBtn.titleLabel?.font = FontFamily.PTSans.regular.font(size: 13)
        mapBtn.titleLabel?.textAlignment = .left
        mapBtn.tintColor = .white
        deleteBtn.tintColor = .white
        deleteBtn.setImage(Asset.cancelBtn.image, for: .normal)
    }
    
    private func setupLabel(label: UILabel, font: UIFont = FontFamily.PTSans.regular.font(size: 13)) {
        label.font = font
        label.textAlignment = .left
        label.textColor = .white
    }
    
    private func setupImgView() {
        doctorImgView.circularImageView()
        doctorImgView.backgroundColor = .white
    }
}
