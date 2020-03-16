//
//  MessageViewController.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 15.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation
import UIKit

class MessageViewController: UIViewController{
    var phone = ""
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageTextField: UITextField!
    @IBAction func previousViewController(_ sender: Any) {
        self.dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
    }
    
    private func setLabel(){
        messageLabel.text = "Введите код из сообщения, отправленного на номер \n\(phone)"
    }
}
