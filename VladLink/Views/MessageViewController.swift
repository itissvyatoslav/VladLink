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
    let person = PersonData.sharedData
    let network = JSONAddPhoneVC()
    var phone = ""
    var code = ""
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageTextField: UITextField!
    @IBAction func previousViewController(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func nextViewController(_ sender: Any) {
        code = messageTextField.text!
        print("!!!!!!! CODE \(code) REQUEST ID \(person.request_id) PHONE NUMBER \(person.phoneNumber)")
        network.postMessageAuth(phoneNumber: person.phoneNumber, request_id: person.request_id, code: code)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
    }
    
    private func setLabel(){
        messageLabel.text = "Введите код из сообщения, отправленного на номер \n\(phone)"
    }
}
