//
//  MainBillCell.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 23.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

protocol MainBillCellDelegate{
    func goToPay(cell: MainBillCell)
    func goToService(cell: MainBillCell)
    func goToChat(cell: MainBillCell)
}

class MainBillCell: UICollectionViewCell {
    let bill = BillModel.sharedData
    var delegate: MainBillCellDelegate?
    
    @IBOutlet weak var billNumber: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var moneyDaysLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBAction func payAction(_ sender: Any) {
        delegate?.goToPay(cell: self)
    }
    
    @IBAction func serviceAction(_ sender: Any) {
        delegate?.goToService(cell: self)
    }
    
    @IBAction func chatAction(_ sender: Any) {
        delegate?.goToChat(cell: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUp(number: Int){
        billNumber.text = "Лицевой счет: \(bill.bills[number].id)"
        let balans = Double(bill.bills[number].bill)
        moneyLabel.text = "\(Int(round(balans ?? 0)))₽"
        if balans ?? 0 < 0 {
            moneyLabel.textColor = .systemRed
        } else {
            moneyLabel.textColor = .systemGreen
        }
        moneyDaysLabel.text = "Days"
        nameLabel.text = bill.bills[number].full_name
        addressLabel.text = bill.bills[number].u_address[0].dom_name
    }
}
