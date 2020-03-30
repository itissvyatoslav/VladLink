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
        if (cityTextField.text != nil && streetTextField.text != nil && buildingTextField.text != nil && porchTextField.text != nil && floorTextField.text != nil && flatTextField.text != nil){
            adressNetwork.newAdress(did: adress.buildingId[buildingTextField.selectedIndex!], flat: flatTextField.text!, porch: porchTextField.text!, floor: floorTextField.text!)
        }
    }
    
    
    override func viewDidLoad() {
        adressNetwork.showCitiesList()
        super.viewDidLoad()
        setDrops()
    }
    
    private func setDrops(){
        cityTextField.delegate = self
        //streetTextField.delegate = self
        cityTextField.optionArray = adress.citiesName
    }
}


extension NewAdressViewController: UITextFieldDelegate{
   // func textFieldDidChangeSelection(_ textField: UITextField) {
   //     guard let number = cityTextField.selectedIndex else { return  }
   //     print(number)
   //    // adressNetwork.showStreetList(city_id: adress.citiesId[number], streetName: "")
   // }
    func textFieldDidEndEditing(_ textField: UITextField) {
        let number1 = cityTextField.selectedIndex ?? 0
        print(number1)
        adressNetwork.showStreetList(city_id: adress.citiesId[number1], streetName: "")
        streetTextField.optionArray = adress.streetsName
        
        let number2 = streetTextField.selectedIndex ?? 0
        print(number2)
        adressNetwork.showBuildingList(street_id: adress.streetsId[number2], buildingNumber: "")
        buildingTextField.optionArray = adress.dname
    }

}
