//
//  infoDateCell.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 01.04.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class infoDateCell: UICollectionViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    var date = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpCell()
    }
    
    func setUpCell(){
        let year = date[0..<4]
        let month = date[5..<7]
        let day = date[8..<10]
        dateLabel.text = "\(day).\(month).\(year)"
    }
}

extension String{
    subscript (r: Range<Int>) -> String {
        var length: Int {
            return count
        }
        
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

