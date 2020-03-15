//
//  AddPhoneViewController.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 14.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation
import UIKit

class AddPhoneViewController: UIViewController{
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var firstSwitch: UISwitch!
    @IBOutlet weak var secondSwitch: UISwitch!
    
    @IBAction func nextViewControllerAction(_ sender: Any) {
        if firstSwitch.isOn {
            let vc = storyboard?.instantiateViewController(identifier: "callVC")
            self.present(vc!, animated: true, completion: nil)
        } else {
            let vc = storyboard?.instantiateViewController(identifier: "messageVC")
            self.present(vc!, animated: true, completion: nil)
        }
    }
    @IBAction func previousViewControllerAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
   
    @IBAction func switch1Action(_ sender: Any) {
        firstSwitch.isOn = true
        secondSwitch.isOn = false
    }
    @IBAction func switch2Action(_ sender: Any) {
        firstSwitch.isOn = false
        secondSwitch.isOn = true
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
