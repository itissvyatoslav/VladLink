//
//  DataService.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 25.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation
import Locksmith

class DataService {
    let person = PersonModel.sharedData
    
    func saveData(){
        let auth_token = person.auth_token
        let phoneNumber = person.phoneNumber
        do {
            try Locksmith.saveData(data: ["auth_token": auth_token, "phoneNumber": phoneNumber], forUserAccount: "MainUser")
        } catch {
            print("error save")
        }
    }
    
    func getData(){
        var semaphore = DispatchSemaphore (value: 0)

        let data = Locksmith.loadDataForUserAccount(userAccount: "MainUser") ?? ["auth_token": "", "phoneNumber": ""]
        person.auth_token = data["auth_token"] as! String
        person.phoneNumber = data["phoneNumber"] as! String
        print("Loaded: \(person.auth_token) and \(person.phoneNumber)")
        semaphore.signal()
        semaphore.wait()
    }
    
    func updateData(){
        let auth_token = person.auth_token
        let phoneNumber = person.phoneNumber
        do {
            try Locksmith.updateData(data: ["auth_token": auth_token, "phoneNumber": phoneNumber], forUserAccount: "MainUser")
        } catch {
            print("error update")
        }
    }
}
