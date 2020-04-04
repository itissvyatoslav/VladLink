//
//  PhoneLabelPlusCell.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 01.04.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class PhoneLabelPlusCell: UICollectionViewCell {
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpCell(number: String){
        phoneLabel.text = "Лицевой счёт: \(number)"
    }


}
