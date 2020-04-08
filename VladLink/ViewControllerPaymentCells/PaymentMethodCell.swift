//
//  PaymentMethodCell.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 08.04.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class PaymentMethodCell: UICollectionViewCell {
    let pay = PayModel.sharedData

    @IBAction func actionButton(_ sender: Any) {
        
    }
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(_ number: Int){
        nameLabel.text = pay.paymentMethods[number].name
        descriptionLabel.text = pay.paymentMethods[number].descr
    }

}
