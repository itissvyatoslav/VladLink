//
//  NewAdressViewController.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 27.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation
import UIKit
import iOSDropDown

class NewAdressViewController: UIViewController{
    let adressNetwork = NewAdress()
    let adress = AdressModel.sharedData
    
    @IBOutlet weak var cityTextField: DropDown!
    @IBOutlet weak var streetTextField: DropDown!
    @IBOutlet weak var buildingTextField: DropDown!
    @IBOutlet weak var porchTextField: UITextField!
    @IBOutlet weak var floorTextField: UITextField!
    @IBOutlet weak var flatTextField: UITextField!
    
    @IBAction func sendRequestAction(_ sender: Any) {
        
    }
    
    
    override func viewDidLoad() {
        adressNetwork.showCitiesList()
        adressNetwork.showStreetList(city_id: adress.citiesId[0], streetName: "")
        super.viewDidLoad()
        setDrops()
    }
    
    private func setDrops(){
        streetTextField.delegate = self
        cityTextField.optionArray = adress.citiesName
        adressNetwork.showStreetList(city_id: adress.citiesId[0], streetName: "")
        streetTextField.optionArray = adress.streetsName//["1street", "2street", "3 street"]
        buildingTextField.optionArray = ["1building", "2building"]
    }
}


extension NewAdressViewController: UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
    //    adressNetwork.showStreetList(city_id: adress.citiesId[0], streetName: textField.text ?? "")
    }
}
