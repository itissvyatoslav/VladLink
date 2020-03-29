//
//  BillCell.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 20.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class BillCell: UICollectionViewCell {
    let bill = BillModel.sharedData

    @IBOutlet weak var billNumber: UILabel!
    @IBOutlet weak var billName: UILabel!
    @IBOutlet weak var billAddress: UILabel!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var countChar: UILabel!
    @IBOutlet weak var exampleLabel: UILabel!
    @IBOutlet weak var switcher: UISwitch!
    @IBOutlet weak var notMyBill: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUp(number: Int){
        switcher.isOn = false
        billNumber.text = "Лицевой счет \(bill.bills[number].id)"
        billName.text = bill.bills[number].full_name
        billAddress.text = bill.bills[number].u_address[0].dom_name
        setCountLabel(label: countChar, textField: commentTextField)
        exampleLabel.text = "Например, \"моя квартира\", \"квартира родителей\"."
        notMyBill.text = "Это не мой лицевой счет"
        checkMaxLength(textField: commentTextField)
    }
    
    private func checkMaxLength(textField: UITextField!) {
        if (textField.text!.count > 10) {
            textField.deleteBackward()
        }
    }
    
    private func setCountLabel(label: UILabel!, textField: UITextField!){
        label.text = "\(textField.text!.count)/128"
    }

}
