//
//  ServiceCell.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 31.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

protocol ServiceCellDelegate {
    func goControll(cell: ServiceCell)
}

class ServiceCell: UICollectionViewCell {

    let titles = ["Тариф", "Интерактивное ТВ", "Кабельное ТВ", "Дополнительные услуги", "Приобрести оборудование"]
    let subtitles = ["Смена тарифного плана", "Услуги Интерактивного ТВ", "Услуги кабельного ТВ", "Статический IP и др.", "Медиаценты, WiFi роутеры\nдругое."]
    let textbuttons = ["ИЗМЕНИТЬ", "ИЗМЕНИТЬ", "ИЗМЕНИТЬ", "ИЗМЕНИТЬ", "ОТКРЫТЬ"]
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBAction func buttonPressAction(_ sender: Any) {
        delegate?.goControll(cell: self)
    }
    var delegate: ServiceCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(number: Int){
        titleLabel.text = titles[number]
        subtitleLabel.text = subtitles[number]
        actionButton.setTitle(textbuttons[number], for: .normal)
    }

}
