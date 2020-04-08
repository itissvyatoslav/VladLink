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
    
    func addAnotherPayment(){
        let apple_pay = Payment(id: "4", key: "apple_pay", active: true, name: "Apple Pay", descr: "Оплата через сервисы Apple.", type: "1", icon: "", data: PayModel.infoData(msg: "", info: ""), order: "4", show_in: ["1", "2"], available_for: "2")
        let cards = Payment(id: "5", key: "cards", active: true, name: "Привязанные карты и автоплатежи", descr: "Управление привязанными картами\nи настройка автоплатежей.", type: "1", icon: "", data: PayModel.infoData(msg: "", info: ""), order: "5", show_in: ["1", "2"], available_for: "2")
        let promise = Payment(id: "6", key: "promise", active: true, name: "Обещанный платёж", descr: "Отсрочка платежа\nПериод действия услуги 3 дня.", type: "1", icon: "", data: PayModel.infoData(msg: "", info: ""), order: "6", show_in: ["1", "2"], available_for: "2")
        paymentMethods.insert(apple_pay, at: 1)
        paymentMethods.insert(cards, at: 2)
        paymentMethods.insert(promise, at: 5)
    }
    static let sharedData = PayModel()
}
