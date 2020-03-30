//
//  AdressModel.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 29.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation

class AdressModel {
    
    var citiesName = [String]()
    var citiesId = [String]()
    
    var streetsName = [String]()
    var streetsId = [String]()
    
    var buildingId = [String]()
    var dname = [String]()
    
    var state: Int = 0
    
    static let sharedData = AdressModel()
}
