//
//  NetworkServiceAccount.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 19.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation

class JSONService{
    
    func getBills(){
        guard let url = URL(string: "https://test-api.vladlink.ru/v1/public/users/my?select={{fields}}") else {
            print("url error")
            return
        }
        let session = URLSession.shared
        
    }
}
