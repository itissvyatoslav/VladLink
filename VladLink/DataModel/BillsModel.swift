//
//  BillsModel.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 19.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation

class BillModel{
    var bills = [bill]()
    var addedBill = bill(balls: "", bill: "", block: false, city_id: "", email: nil, full_name: "", id: "", is_juridical: false, is_sms: [""], skidko: "", tariff: "", tariff_current: BillModel.tariffCurrent(abonpay: "", tid: "", tname: ""), tariff_next: "", u_address: [BillModel.uAddress(descr: "", did: "", dom_name: "", floor: "", porch: "")], ulogin: "")
    
    var jsonRequest =  requestBill()
    
    struct requestBill: Codable {
        var data = [bill]()
        var paginate: paginateStruct = paginateStruct(count_item: 0, count_page: 0)
        var status: Int = 0
    }
    
    struct bill: Codable {
        var balls: String
        var bill: String
        var block: Bool
        var city_id: String
        var email: String?
        var full_name: String
        var id: String
        var is_juridical: Bool
        var is_sms: [String]
        var skidko: String
        var tariff: String
        var tariff_current: tariffCurrent
        var tariff_next: String
        var u_address: [uAddress]
        var ulogin: String
    }
    
    struct tariffCurrent: Codable{
        var abonpay: String
        var tid: String
        var tname: String
    }
    
    struct uAddress: Codable {
        var descr: String
        var did: String
        var dom_name: String
        var floor: String?
        var porch: String
    }
    
    struct paginateStruct: Codable{
        var count_item: Int
        var count_page: Int
    }
    
    static let sharedData = BillModel()
    
}

