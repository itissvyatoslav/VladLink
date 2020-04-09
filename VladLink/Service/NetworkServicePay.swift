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
                self.pay.paymentMethods.removeAll()
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
                        self.pay.addPaymentMethods.show_in.append(json.data[number].show_in[subNumber])
                    }
                    self.pay.addPaymentMethods.available_for = json.data[number].available_for
                    self.pay.paymentMethods.append(self.pay.addPaymentMethods)
                }
            } catch {
                print(error)
            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
        pay.addAnotherPayment()
    }
    
    func getHistory(number: Int, date_from: String, date_to: String){
        struct answerReceive: Codable{
            var status: Int
            var data: [dataReceive]
        }
        
        struct dataReceive: Codable{
            var type: String
            var date: String
            var amount: String
            var name: String
        }
        
        guard let url = URL(string: "https://test-api.vladlink.ru/v1/history/paymentHistory") else {
            print("url error")
            return
        }
        let parametrs = ["public_uid": person.publicUids[number], "date_from": date_from, "date_to": date_to, "type": "0,1"]
        let parametr = ["data": parametrs]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("\(person.auth_token)", forHTTPHeaderField: "Authorization")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parametr, options: []) else {
            print("JSON error")
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request){(data, response, error)  in
            if let response = response{
                print(response)
            }
            
            guard let data = data else {
                print("data error")
                return
            }
            do {
                let json = try JSONDecoder().decode(answerReceive.self, from: data)
                //let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                self.pay.history.removeAll()
                for number in 0..<json.data.count{
                    self.pay.addHistory.type = json.data[number].type
                    self.pay.addHistory.date = json.data[number].date
                    self.pay.addHistory.amount = json.data[number].amount
                    self.pay.addHistory.name = json.data[number].name
                    self.pay.history.append(self.pay.addHistory)
                }
                print(self.pay.history)
            } catch {
                print(error)
            }
        }.resume()
    }
}
