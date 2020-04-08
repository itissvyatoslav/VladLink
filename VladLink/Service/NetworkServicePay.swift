//
//  NetworkServicePay.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 07.04.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation

class BillService{
    let pay = PayModel.sharedData
    let person = PersonModel.sharedData
    let tariff = TariffModel.sharedData
    
    func getPayList(number: Int){
        
        struct answerReceive: Codable{
            var status: Int
            var data: [dataReceive]
        }
        
        struct dataReceive: Codable{
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
        
        struct infoData: Codable{
            var msg: String
            var info: String
        }
        
        let semaphore = DispatchSemaphore (value: 0)
        var request = URLRequest(url: URL(string: "https://test-api.vladlink.ru/v1/online/payments?public_uid=\(person.publicUids[number])&source=1&active=1&order=order")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("\(person.auth_token)", forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let json = try JSONDecoder().decode(answerReceive.self, from: data)
                print(json)
                for number in 0..<json.data.count {
                    self.pay.addPaymentMethods.id = json.data[number].id
                    self.pay.addPaymentMethods.key = json.data[number].key
                    self.pay.addPaymentMethods.active = json.data[number].active
                    self.pay.addPaymentMethods.name = json.data[number].name
                    self.pay.addPaymentMethods.descr = json.data[number].descr
                    self.pay.addPaymentMethods.type = json.data[number].type
                    self.pay.addPaymentMethods.data.msg = json.data[number].data.msg
                    self.pay.addPaymentMethods.data.info = json.data[number].data.info
                    self.pay.addPaymentMethods.order = json.data[number].order
                    for subNumber in 0..<json.data[number].show_in.count{
                        self.pay.addPaymentMethods.show_in[subNumber] = json.data[number].show_in[subNumber]
                    }
                    self.pay.addPaymentMethods.available_for = json.data[number].available_for
                }
            } catch {
                print(error)
            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
    }
}
