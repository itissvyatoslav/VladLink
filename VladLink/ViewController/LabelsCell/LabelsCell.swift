//
//  LabelsCell.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 21.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class LabelsCell: UICollectionViewCell {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUp(phoneNumber: String){
        label1.text = "Вы успешно подтвердили номер:"
        label2.text = phoneNumber
        label3.text = "Данный телефонный номер указан как контактный\nдля следующих лицевых счетов:"
    }
}
