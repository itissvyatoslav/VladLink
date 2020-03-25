//
//  PersonData.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 16.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation

class PersonModel{
    var phoneNumber = "" //Номер телефона
    var maybePhoneNumber = "" //Номер телефона до подтверждения
    var request_id = ""
    var callPhoneNumber = "" //Номер на который звонить
    var auth_token = ""
    var name = ""
    var uid = ""
    var publicUids = [String]()
    
    var formatedPhoneNumber = ""
    
    
    static let sharedData = PersonModel()
}

