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
    let person = PersonModel.sharedData
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
        network.postMessageAuth(phoneNumber: person.phoneNumber, request_id: person.request_id, code: code)
        if person.auth_token == "" {
            infoWindow()
        } else {
            let vc = storyboard?.instantiateViewController(identifier: "firstEnterVC") as! UINavigationController
            self.present(vc, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
    }
    
    private func setLabel(){
        messageLabel.text = "Введите код из сообщения, отправленного на номер \n\(phone)"
    }
    
    let titleWindow = "Упс!"
    let messageWindow = "Что-то случилось, попробуйте еще"
    
    private func infoWindow(){
        let alertController = UIAlertController(
            title: titleWindow,
            message: messageWindow,
            preferredStyle: .alert)
        alertController.addAction(UIAlertAction(
            title: "Закрыть",
            style: .default,
            handler: { _ in
                alertController.dismiss(animated: true, completion: nil)
        }))
        present(alertController, animated: true, completion: nil)
    }
}
