//
//  historyCell.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 08.04.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

protocol historyCellDelegate {
    func showHistory(cell: historyCell)
}

class historyCell: UICollectionViewCell {

    @IBOutlet weak var historyButton: UIButton!
    @IBAction func historyAction(_ sender: Any) {
        delegate?.showHistory(cell: self)
    }
    
    var delegate: historyCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
