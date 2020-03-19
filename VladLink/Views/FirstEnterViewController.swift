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
    let network = JSONService()
    let person = PersonModel.sharedData
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var billsStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        network.getBills(auth_token: person.auth_token)
    }
    
    private func setView(){
        phoneNumberLabel.text = person.formatedPhoneNumber
    }
    
}
