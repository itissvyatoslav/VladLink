//
//  ViewController.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 14.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class GreetingViewController: UIViewController {
    let ns = JSONAddPhoneVC()
    
    let titleWindow = "Внимание!"
    let messageWindow =   """
                    Позвоните в контактный центр по телефону
                    +7 (423) 230 21 00
                    """
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }    
    
    @IBAction func callCentrActionButton(_ sender: Any) {
        if let url = URL(string: "tel://+74232302100"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func notUserActionButton(_ sender: Any) {
        infoWindow()
    }
    
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

