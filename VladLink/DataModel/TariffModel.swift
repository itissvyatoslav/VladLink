//
//  TariffModel.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 31.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation

class TariffModel {
    
    var actualTariffNumber = -1
    
    var tariff = ""
    var tariffNext = ""
    
    var tariffs = [tariffInfo]()
    var addTariff = tariffInfo(abo: "", tid: "", tname: "", speed: "", channels_count_itv: "", channels_count_ctv: "", cost_local: "", cost_archive: "", can_ch: nil, activ: "", tchange: "")
    
    struct tariffInfo {
        var abo: String
        var tid: String
        var tname: String
        var speed: String
        var channels_count_itv: String
        var channels_count_ctv: String
        var cost_local: String
        var cost_archive: String
        var can_ch: String?
        var activ: String
        var tchange: String
    }
    
    var products = [Product]()
    var products1 = [Product]()
    var products2 = [Product]()
    var productsCTV = [Product]()
    var productsITV = [ProductITV]()
    
    var addProduct = Product(id: "", name: "", is_active: "", on_deactive: "", can_add: "", days_gone: "", group_id: "", promo: "", cost: "", is_available: "")
    
    struct Product {
        var id: String
        var name: String
        var is_active: String
        var on_deactive: String
        var can_add: String
        var days_gone: String
        var group_id: String
        var promo: String
        var cost: String
        var is_available: String
    }
    
    var addProductITV = ProductITV(id: "", name: "", is_active: "", price: "", free: "", days_gone: "", test_period: "")
    
    var status_msg = "Status Message"
    
    struct ProductITV {
        var id: String
        var name: String
        var is_active: String
        var price: String
        var free: String
        var days_gone: String
        var test_period: String
    }
    
    var devices = [Device]()
    var addDevice = Device(id: "", device_name: "", description: "", cost: "", installment_plan: "", installment_cost: "", device_img: "", order_descr: "", order_descr_installment: "")
    
    struct Device {
        var id: String
        var device_name: String
        var description: String
        var cost: String
        var installment_plan: String?
        var installment_cost: String?
        var device_img: String
        var order_descr: String
        var order_descr_installment: String
    }
    
    static let sharedData = TariffModel()
}
