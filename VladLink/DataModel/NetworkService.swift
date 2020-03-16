//
//  JSONParserAddPhoneVC.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 16.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation

class JSONAddPhoneVC{
    func phoneRequest(){
        
    }
    
    func messageRequest(phoneNumber: String){
        guard let url = URL(string: "https://test-api.vladlink.ru/v1/auth/subscribers/authByCode/request") else {
            print("error url")
            return
        }
        let parametrs = ["phone": "\(phoneNumber)"]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parametrs, options: []) else {
            print("JSONSerialization error")
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response{
                print(response)
            }
            guard let data = data else {
                print("data error")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
}
