//
//  FirstEnterViewController.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 19.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation
import UIKit

class FirstEnterViewController: UIViewController {
    let person = PersonData.sharedData
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    private func setView(){
        phoneNumberLabel.text = person.formatedPhoneNumber
    }
}
