//
//  ButtonsServiceCell.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 01.04.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

protocol ButtonsServiceCellDelegate {
    func newTariff()
    func goBackVC()
}

class ButtonsServiceCell: UICollectionViewCell {
    var delegate: ButtonsServiceCellDelegate?
    
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func yesButtonAction(_ sender: Any) {
        self.delegate?.newTariff()
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.delegate?.goBackVC()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
