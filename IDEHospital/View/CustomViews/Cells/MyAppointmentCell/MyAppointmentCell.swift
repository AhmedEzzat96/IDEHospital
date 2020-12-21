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
    
    //MARK:- Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func mapBtnPressed(_ sender: UIButton) {
    }
    
}
