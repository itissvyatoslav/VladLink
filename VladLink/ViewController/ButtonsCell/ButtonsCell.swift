//
//  ButtonsCell.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 21.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//
import Foundation
import UIKit

class ButtonsCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func nextViewController(_ sender: Any) {
        let vc = MainViewController()
        vc.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func previousViewController(_ sender: Any) {
    }
}

