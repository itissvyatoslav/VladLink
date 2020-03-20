//
//  EditCellBillView.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 20.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation
import UIKit

class EditBillCell: UICollectionViewCell{
    
    @IBOutlet weak var billNumberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var countCharLabel: UILabel!
    @IBOutlet weak var exampleLabel: UILabel!
    @IBOutlet weak var switcher: UISwitch!
    @IBOutlet weak var notMyBillLabel: UILabel!
    
    func setLabel(){
        exampleLabel.text = "Например, \"моя квартира\", \"квартира родителей\"."
        notMyBillLabel.text = "Это не мой лицевой счет"
    }
    
}
