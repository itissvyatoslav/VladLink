//
//  deviceCell.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 07.04.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

protocol deviceCellDelegate{
    func getDevice(cell: deviceCell)
    func getDevicePlan(cell: deviceCell)
}

class deviceCell: UICollectionViewCell {
    let tariff = TariffModel.sharedData

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var planLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var planButton: UIButton!
    
    @IBAction func buyAction(_ sender: Any) {
        delegate?.getDevice(cell: self)
    }
    @IBAction func planAction(_ sender: Any) {
        delegate?.getDevicePlan(cell: self)
    }
    
    var delegate: deviceCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setUpCell(_ number: Int){
        nameLabel.text = tariff.devices[number].device_name
        costLabel.text = tariff.devices[number].cost
        planLabel.isHidden = true
        planButton.isHidden = true
    }
    
    func setUpCellPost(_ number: Int){
        nameLabel.text = tariff.devices[number].device_name
        costLabel.text = "Стоимость: \(tariff.devices[number].cost) ₽"
        planLabel.text = "Рассрочка на \(tariff.devices[number].installment_plan) месяцев:\n\(tariff.devices[number].installment_cost) ₽/месяц"
    }
}
