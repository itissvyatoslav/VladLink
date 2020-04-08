//
//  PayModel.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 07.04.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation

class PayModel {
    
    struct Payment{
        var id: String
        var key: String
        var active: Bool
        var name: String
        var descr: String
        var type: String
        var icon: String
        var data: infoData
        var order: String
        var show_in: [String]
        var available_for: String
    }
    
    struct infoData {
        var msg: String
        var info: String
    }
    
    var addPaymentMethods = Payment(id: "", key: "", active: false, name: "", descr: "", type: "", icon: "", data: PayModel.infoData(msg: "", info: ""), order: "", show_in: [String](), available_for: "")
    
    var paymentMethods = [Payment]()
    static let sharedData = PayModel()
}
