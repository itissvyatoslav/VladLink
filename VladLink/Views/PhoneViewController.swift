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
    let network = JSONAddPhoneVC()
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
    
    @IBAction func nextViewController(_ sender: Any) {
        network.postPhoneAuth()
        sleep(2)
        if person.auth_token == "" {
            infoWindow()
        } else {
            let vc = storyboard?.instantiateViewController(identifier: "firstEnterVC") as! UINavigationController
            self.present(vc, animated: true, completion: nil)
        }
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
