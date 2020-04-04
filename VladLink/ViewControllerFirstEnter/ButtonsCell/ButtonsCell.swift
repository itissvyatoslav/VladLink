//
//  ButtonsCell.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 21.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//
import Foundation
import UIKit

protocol ButtonsCellDelegate {
    func nextViewController()
    func previousViewController()
}

class ButtonsCell: UICollectionViewCell {
    var delegate: ButtonsCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func nextViewController(_ sender: Any) {
        delegate?.nextViewController()
    }
    
    @IBAction func previousViewController(_ sender: Any) {
        delegate?.previousViewController()
    }
}

