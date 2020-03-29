//
//  NewAdressViewController.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 27.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation
import UIKit


class NewAdressViewController: UIViewController{
    let adressNetwork = NewAdress()
    
    @IBAction func newAdressAction(_ sender: Any) {
        adressNetwork.showCitiesList()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
