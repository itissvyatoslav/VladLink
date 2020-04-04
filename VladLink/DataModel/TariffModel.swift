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
    
    static let sharedData = TariffModel()
}
