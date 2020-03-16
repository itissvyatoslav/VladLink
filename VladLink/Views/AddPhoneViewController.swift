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
    var phoneNumber = ""
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var firstSwitch: UISwitch!
    @IBOutlet weak var secondSwitch: UISwitch!
    
    @IBAction func nextViewControllerAction(_ sender: Any) {
        if firstSwitch.isOn {
            let vc = storyboard?.instantiateViewController(identifier: "callVC") as! PhoneViewController
            vc.phone = phoneTextField.text!
            self.present(vc, animated: true, completion: nil)

        } else {
            let vc = storyboard?.instantiateViewController(identifier: "messageVC") as! MessageViewController
            vc.phone = phoneTextField.text!
            self.present(vc, animated: true, completion: nil)
        }
        phoneNumber = deformattedNumber(number: phoneTextField.text!)
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
        phoneTextField.delegate = self
    }
    
    private func formattedNumber(number: String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "X (XXX) XXX-XXXX"

        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    private func deformattedNumber(number: String) -> String{
        var result = number.replacingOccurrences(of: " ", with: "")
        result = result.replacingOccurrences(of: "(", with: "")
        result = result.replacingOccurrences(of: ")", with: "")
        result = result.replacingOccurrences(of: "-", with: "")
        return result
    }
}

extension AddPhoneViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = formattedNumber(number: newString)
        return false
    }
}
