//
//  itvCell.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 04.04.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

protocol itvCellDelegate {
    func deactiveService(cell: itvCell)
    func activeService(cell: itvCell)
}

class itvCell: UICollectionViewCell {
    
    let tariff = TariffModel.sharedData
    var delegate: itvCellDelegate?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var offButton: UIButton!
    @IBOutlet weak var onButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBAction func offAction(_ sender: Any) {
        delegate?.deactiveService(cell: self)
    }
    @IBAction func onAction(_ sender: Any) {
        delegate?.activeService(cell: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpCellITV(_ number: Int){
        nameLabel.text = tariff.productsITV[number].name
        costLabel.text = "Стоимость: \(tariff.productsITV[number].price) ₽/мес"
        let promoNumber = Int(tariff.productsITV[number].test_period) ?? 0
        let daysNumber = Int(tariff.productsITV[number].days_gone) ?? 0
        setUpStock(promoNumber, daysNumber)
        setUpButtonsITV(number)
    }
    
    func setUpCell(_ number: Int){
        nameLabel.text = tariff.products[number].name
        if tariff.products[number].group_id == "2"{
            costLabel.text = "Стоимость: \(tariff.products[number].cost) ₽/день"
        } else {
            costLabel.text = "Стоимость: \(tariff.products[number].cost) ₽/мес"
        }
        if tariff.products[number].is_available == "1"{
            stockLabel.text = "Включено в ваш тарифный план"
        } else {
            let promoNumber = Int(tariff.products[number].promo) ?? 0
            let daysNumber = Int(tariff.products[number].days_gone) ?? 0
            setUpStock(promoNumber, daysNumber)
        }
        setUpButtons(number)
        if tariff.products[number].group_id == "3"{
            setUpForCTV(number)
        }
    }
    
    private func setUpStock(_ promoNumber: Int, _ daysNumber: Int){
       
        let stock = promoNumber - daysNumber
        if stock > 0 {
            if stock % 10 == 1 && stock != 11 {
                stockLabel.text = "Акция: \(stock) день - 0 рублей!"
            } else if (stock % 10 == 2 || stock % 10 == 3 || stock % 10 == 4) && (stock < 10 || stock > 20 ){
                stockLabel.text = "Акция: \(stock) дня - 0 рублей!"
            } else {
                stockLabel.text = "Акция: \(stock) дней - 0 рублей!"
            }
        } else {
            stockLabel.isHidden = true
        }
    }
    
    private func setUpButtons(_ number: Int){
        print(tariff.products[number].is_active)
        print(tariff.products[number].on_deactive)
        print(tariff.products[number].can_add)
        if tariff.products[number].is_active == "t" {
            onButton.isHidden = true
            offButton.isHidden = true
            infoLabel.isHidden = false
            infoLabel.text = "ВКЛЮЧЕНО"
        }
        if tariff.products[number].on_deactive == "t"{
            onButton.isHidden = true
            offButton.isHidden = false
            infoLabel.isHidden = true
        }
        if tariff.products[number].can_add == "t" {
            onButton.isHidden = false
            offButton.isHidden = true
            infoLabel.isHidden = true
        }
    }
    
    private func setUpButtonsITV(_ number: Int){
        infoLabel.isHidden = true
        if tariff.productsITV[number].is_active == "t" {
            onButton.isHidden = true
            offButton.isHidden = false
        } else {
            onButton.isHidden = false
            offButton.isHidden = true
        }
    }
    
    private func setUpForCTV(_ number: Int){
        onButton.setTitle("ЗАЯВКА", for: .normal)
        print(tariff.status_msg)
        if (tariff.products[number].is_active == "f" && tariff.products[number].can_add == "f" && tariff.status_msg == "") || (tariff.products[number].is_active == "f" && tariff.products[number].is_available == "0" && tariff.status_msg == ""){
            onButton.isHidden = true
            offButton.isHidden = true
            infoLabel.isHidden = true
            stockLabel.text = "Дом пока не подключен"
        }
    }

}
