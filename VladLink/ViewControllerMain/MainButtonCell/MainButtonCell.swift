//
//  MainButtonCell.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 23.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

protocol MainButtonCellDelegate {
    func billControlAction()
    func newAdressAction()
}

class MainButtonCell: UICollectionViewCell {
    var delegate: MainButtonCellDelegate?
    @IBAction func billControlAction(_ sender: Any) {
        delegate?.billControlAction()
    }
    
    @IBAction func newAdressAction(_ sender: Any) {
        delegate?.newAdressAction()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
