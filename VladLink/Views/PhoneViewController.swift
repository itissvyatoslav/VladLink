//
//  PhoneViewController.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 15.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation
import UIKit

class PhoneViewController: UIViewController{
    let person = PersonData.sharedData
    var phone = ""
    var phoneCall = ""
    
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBAction func callAction(_ sender: Any) {
        if let url = URL(string: "tel://\(phoneCall)"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    @IBAction func previousViewControllerAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
    }
    
    private func setLabels(){
        phoneLabel.text = "В течении 2-х минут позвоните с номера  \n\(phone)\nна бесплатный номер."
        infoLabel.text = "После набора соединение автоматически сбросится (звонок будет бесплатным для вас)."
        phoneButton.setTitle(phoneCall, for: .normal)
    }
}
