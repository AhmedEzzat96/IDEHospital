//
//  TimeCell.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 04/01/2021.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import UIKit

class TimeCell: UICollectionViewCell {
    // MARK:- IBOutlets
    @IBOutlet weak var timeLabel: UILabel!
    
    //MARK:- Properties
    private var viewModel: TimeCellViewModelProtocol!
    
    // MARK:- Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        viewModel = TimeCellViewModel()
    }
    
    // MARK:- Public Methods
    func configure(item: DoctorAppointmentTime) {
        timeLabel.text = viewModel.createTime(timestamp: item.time)
        if item.booked {
            self.backgroundColor = ColorName.steelGrey.color
            self.isUserInteractionEnabled = false
            self.timeLabel.textColor = UIColor(displayP3Red: 178/255, green: 177/255, blue: 177/255, alpha: 1)
        } else {
            self.isUserInteractionEnabled = true
            self.backgroundColor = ColorName.niceBlue.color
            self.timeLabel.textColor = .white
        }
    }
    
    func toggleSelected () {
        if isSelected{
            backgroundColor = ColorName.darkRoyalBlue.color
        } else {
            backgroundColor = ColorName.niceBlue.color
        }
    }
}

// MARK:- Private Methods
extension TimeCell {
    private func setup() {
        setupView()
        setupTimeLabel()
    }
    
    private func setupView() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        backgroundColor = ColorName.niceBlue.color
    }
    
    private func setupTimeLabel() {
        timeLabel.font = FontFamily.PTSans.bold.font(size: 12)
    }
}
