//
//  PhoneCell.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 22.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

protocol PhoneCellDelegate{
    func changePhone()
}

class PhoneCell: UICollectionViewCell {
    var delegate: PhoneCellDelegate?

    @IBOutlet weak var phoneLabel: UILabel!
    @IBAction func changeButton(_ sender: Any) {
        delegate?.changePhone()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUp(phoneNumber: String){
        phoneLabel.text = phoneNumber
    }

}
