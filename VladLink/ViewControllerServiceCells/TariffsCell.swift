//
//  TariffsCell.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 31.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

protocol TariffsCellDelegate {
    func goToChangeTariff(cell: TariffsCell)
}

class TariffsCell: UICollectionViewCell {
    let tariff = TariffModel.sharedData
    var delegate: TariffsCellDelegate?
    
    @IBAction func goToChangeTariffVC(_ sender: Any) {
        self.delegate?.goToChangeTariff(cell: self)
    }
    
    
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var itvLabel: UILabel!
    @IBOutlet weak var ctvLabel: UILabel!
    @IBOutlet weak var localLabel: UILabel!
    @IBOutlet weak var archiveLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpForChanging(number: Int, newNumber: Int){
        if number == 1{
            nameLabel.text = tariff.tariffs[tariff.actualTariffNumber].tname
            priceLabel.text = "\(tariff.tariffs[tariff.actualTariffNumber].abo) ₽/мес"
            speedLabel.text = "\((Int(tariff.tariffs[tariff.actualTariffNumber].speed) ?? 0)/1000) Мбит/с"
            itvLabel.text = tariff.tariffs[tariff.actualTariffNumber].channels_count_itv
            ctvLabel.text = tariff.tariffs[tariff.actualTariffNumber].channels_count_ctv
            localLabel.text = "\(tariff.tariffs[tariff.actualTariffNumber].cost_local) ₽/мес"
            archiveLabel.text = "\(tariff.tariffs[tariff.actualTariffNumber].cost_archive) ₽/мес"
            statusLabel.text = "ТЕКУЩИЙ"
            goButton.isHidden = true
        } else {
            nameLabel.text = tariff.tariffs[newNumber].tname
            priceLabel.text = "\(tariff.tariffs[newNumber].abo) ₽/мес"
            speedLabel.text = "\((Int(tariff.tariffs[newNumber].speed) ?? 0)/1000) Мбит/с"
            itvLabel.text = tariff.tariffs[newNumber].channels_count_itv
            ctvLabel.text = tariff.tariffs[newNumber].channels_count_ctv
            localLabel.text = "\(tariff.tariffs[newNumber].cost_local) ₽/мес"
            archiveLabel.text = "\(tariff.tariffs[newNumber].cost_archive) ₽/мес"
            statusLabel.text = "НОВЫЙ"
            goButton.isHidden = true
        }
    }
    
    func setUpCell(number: Int){
        nameLabel.text = tariff.tariffs[number].tname
        priceLabel.text = "\(tariff.tariffs[number].abo) ₽/мес"
        speedLabel.text = "\((Int(tariff.tariffs[number].speed) ?? 0)/1000) Мбит/с"
        itvLabel.text = tariff.tariffs[number].channels_count_itv
        ctvLabel.text = tariff.tariffs[number].channels_count_ctv
        localLabel.text = "\(tariff.tariffs[number].cost_local) ₽/мес"
        archiveLabel.text = "\(tariff.tariffs[number].cost_archive) ₽/мес"
        if  tariff.tariffs[number].activ == "t"{
            goButton.isHidden = true
            statusLabel.text = "ТЕКУЩИЙ"
            tariff.actualTariffNumber = number
        } else if tariff.tariffs[number].tid == tariff.tariffNext{
            goButton.setTitle("ОТМЕНИТЬ", for: .reserved)
            statusLabel.isHidden = true
        } else {
            statusLabel.isHidden = true
        }
    }
}

