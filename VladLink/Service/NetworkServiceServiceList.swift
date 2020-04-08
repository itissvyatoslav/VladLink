//
//  NetworkServiceServiceList.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 31.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation


class ServiceList{
    let person = PersonModel.sharedData
    let tariff = TariffModel.sharedData
    
    func getActuallTariffs(){
        struct answerReceive: Codable{
            var status: Int
            var data: [dataReceive]
            var paginate: paginateReceive
        }
        
        struct dataReceive: Codable{
            var id: String
            var tariff: String
            var tariff_next: String
        }
        
        struct paginateReceive: Codable{
            var count_page: Int
            var count_item: Int
        }
        
        let semaphore = DispatchSemaphore (value: 0)
        var request = URLRequest(url: URL(string: "https://test-api.vladlink.ru/v1/public/users/my?select=id%2Ctariff%2Ctariff_next")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("\(person.auth_token)", forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                //let json = try JSONSerialization.jsonObject(with: data, options: [])
                //print(json)
                let json = try JSONDecoder().decode(answerReceive.self, from: data)
                self.tariff.tariff = json.data[0].tariff
                self.tariff.tariffNext = json.data[0].tariff_next
                //print(self.adress.streetsName)
            } catch {
                print(error)
            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
    }
    
    func getAllTariffs(number: Int){
        struct answerReceive: Codable{
            var status: Int
            var data: [dataReceive]
        }
        
        struct dataReceive: Codable{
            var tid: String
            var tname: String
            var abo: String
            var with_tv: String
            var tchange: String
            var activ: String
            var speed: String
            var local_speed: String
            var can_ch: String?
            var new_tariff: String
            var free_itv: String
            var cost_itv: String
            var channels_count_itv: String
            var free_ctv: String
            var cost_ctv: String
            var channels_count_ctv: String
            var cost_local: String
            var cost_archive: String
        }

        let semaphore = DispatchSemaphore (value: 0)
        var request = URLRequest(url: URL(string: "https://test-api.vladlink.ru/v1/online/tarifs_user/\(person.publicUids[number])")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("\(person.auth_token)", forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                //let json = try JSONSerialization.jsonObject(with: data, options: [])
                //print(json)
                let json = try JSONDecoder().decode(answerReceive.self, from: data)
                self.tariff.tariffs.removeAll()
                for number in 0..<json.data.count{
                    self.tariff.addTariff.abo = json.data[number].abo
                    self.tariff.addTariff.tid = json.data[number].tid
                    self.tariff.addTariff.tname = json.data[number].tname
                    self.tariff.addTariff.speed = json.data[number].speed
                    self.tariff.addTariff.channels_count_itv = json.data[number].channels_count_itv
                    self.tariff.addTariff.channels_count_ctv = json.data[number].channels_count_ctv
                    self.tariff.addTariff.cost_local = json.data[number].cost_local
                    self.tariff.addTariff.cost_archive = json.data[number].cost_archive
                    self.tariff.addTariff.can_ch = json.data[number].can_ch
                    self.tariff.addTariff.activ = json.data[number].activ
                    self.tariff.addTariff.tchange = json.data[number].tchange
                    self.tariff.tariffs.append(self.tariff.addTariff)
                }
                print(self.tariff.tariffs)
            } catch {
                print(error)
            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
    }
    
    func newTariff(account_id: String, tariff_id: String){
        struct errorReceive: Codable{
            var error_message: String
            var status: Int
        }
        
        let semaphore = DispatchSemaphore (value: 0)
        guard let url = URL(string: "https://test-api.vladlink.ru/v1/online/tarifs_user/\(account_id)/set/\(tariff_id)") else {
            print("url error")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("\(person.auth_token)", forHTTPHeaderField: "Authorization")
        
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
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                //let json = try JSONDecoder().decode(errorReceive.self, from: data)
                print(json)
            } catch {
                print(error)
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
    }
    
    func deleteTariff(account_id: String){
        struct errorReceive: Codable{
            var error_message: String
            var status: Int
        }
        
        let semaphore = DispatchSemaphore (value: 0)
        guard let url = URL(string: "https://test-api.vladlink.ru/v1/online/tarifs_user/\(account_id)/cancelChange") else {
            print("url error")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("\(person.auth_token)", forHTTPHeaderField: "Authorization")
        
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
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                //let json = try JSONDecoder().decode(errorReceive.self, from: data)
                print(json)
            } catch {
                print(error)
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
    }
    
    func getProductServices(number: Int){
        struct answerReceive: Codable{
            var status: Int
            var data: [dataReceive]
        }
        
        struct dataReceive: Codable{
            var id: String
            var name: String
            var description: String
            var is_active: String
            var on_deactive: String
            var can_add: String
            var days_gone: String
            var group_id: String
            var group_name: String
            var group_description: String
            var info: [infoReceive]
        }
        
        struct infoReceive: Codable{
            var option_id: String
            var option_name: String
            var option_val: String
        }
        
        let semaphore = DispatchSemaphore (value: 0)
        var request = URLRequest(url: URL(string: "https://test-api.vladlink.ru/v1/online/product_services/\(person.publicUids[number])")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("\(person.auth_token)", forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                //let json = try JSONSerialization.jsonObject(with: data, options: [])
                let json = try JSONDecoder().decode(answerReceive.self, from: data)
                self.tariff.products1.removeAll()
                self.tariff.products2.removeAll()
                self.tariff.productsCTV.removeAll()
                for number in 0..<json.data.count{
                    print(json.data[number].info)
                    self.tariff.addProduct.id = json.data[number].id
                    self.tariff.addProduct.name = json.data[number].name
                    self.tariff.addProduct.is_active = json.data[number].is_active
                    self.tariff.addProduct.on_deactive = json.data[number].on_deactive
                    self.tariff.addProduct.days_gone = json.data[number].days_gone
                    self.tariff.addProduct.group_id = json.data[number].group_id
                    for infoNumber in 0..<json.data[number].info.count{
                        if json.data[number].info[infoNumber].option_id == "28"{
                            self.tariff.addProduct.cost = json.data[number].info[infoNumber ].option_val
                        }
                        if json.data[number].info[infoNumber].option_id == "26"{
                            self.tariff.addProduct.promo = json.data[number].info[infoNumber ].option_val
                        }
                        if json.data[number].info[infoNumber].option_id == "1"{
                            self.tariff.addProduct.is_available = json.data[number].info[infoNumber ].option_val
                        }
                        
                    }
                    if self.tariff.addProduct.group_id == "1"{
                        self.tariff.products1.append(self.tariff.addProduct)
                    }
                    if self.tariff.addProduct.group_id == "2" {
                        self.tariff.products2.append(self.tariff.addProduct)
                    }
                    if self.tariff.addProduct.group_id == "3" {
                        self.tariff.productsCTV.append(self.tariff.addProduct)
                    }
                }
            } catch {
                print(error)
            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
    }
    
    func changeProductService(OP: String, service_id: String, number: Int){
        struct errorReceive: Codable{
            var error_message: String
            var status: Int
        }
        
        struct answerReceive: Codable{
            var status: Int
            var data: Data
        }
        
        struct Data: Codable{
            var success: Bool
        }
        
        let semaphore = DispatchSemaphore (value: 0)
        guard let url = URL(string: "https://test-api.vladlink.ru//v1/online/product_services/\(person.publicUids[number])/\(OP)/\(service_id)") else {
            print("url error")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("\(person.auth_token)", forHTTPHeaderField: "Authorization")
        
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
                //let json = try JSONSerialization.jsonObject(with: data, options: [])
                //print(json)
                let json = try JSONDecoder().decode(errorReceive.self, from: data)
                print(json.error_message)
            } catch {
                print(error)
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
    }
    
    func getProductITV(number: Int){
        struct answerReceive: Codable{
            var status: Int
            var data: [dataReceive]
        }
        
        struct dataReceive: Codable{
            var id: String
            var name: String
            var is_active: String
            var price: String
            var free: String
            var days_gone: String
            var test_period: String
        }
        
        let semaphore = DispatchSemaphore (value: 0)
        var request = URLRequest(url: URL(string: "https://test-api.vladlink.ru/v1/online/mw_services/\(person.publicUids[number])")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("\(person.auth_token)", forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
               //let json = try JSONSerialization.jsonObject(with: data, options: [])
                self.tariff.productsITV.removeAll()
                let json = try JSONDecoder().decode(answerReceive.self, from: data)
                for number in 0..<json.data.count{
                    self.tariff.addProductITV.id = json.data[number].id
                    self.tariff.addProductITV.name = json.data[number].name
                    self.tariff.addProductITV.is_active = json.data[number].is_active
                    self.tariff.addProductITV.price = json.data[number].price
                    self.tariff.addProductITV.free = json.data[number].free
                    self.tariff.addProductITV.days_gone = json.data[number].days_gone
                    self.tariff.addProductITV.test_period = json.data[number].test_period
                    self.tariff.productsITV.append(self.tariff.addProductITV)
                }
            } catch {
                print(error)
            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
    }
    
    func changeProductITVService(OP: String, service_id: String, number: Int){
        struct errorReceive: Codable{
            var error_message: String
            var status: Int
        }
        
        struct answerReceive: Codable{
            var status: Int
            var data: Data
        }
        
        struct Data: Codable{
            var success: Bool
        }
        
        let semaphore = DispatchSemaphore (value: 0)
        guard let url = URL(string: "https://test-api.vladlink.ru/v1/online/mw_services/\(person.publicUids[number])/\(OP)/\(service_id)") else {
            print("url error")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("\(person.auth_token)", forHTTPHeaderField: "Authorization")
        
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
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                //let json = try JSONDecoder().decode(errorReceive.self, from: data)
                //print(json.error_message)
            } catch {
                print(error)
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
    }
    
    func changeProductCTVService(OP: String, number: Int){
        struct errorReceive: Codable{
            var error_message: String
            var status: Int
        }
        
        struct answerReceive: Codable{
            var status: Int
            var data: Data
        }
        
        struct Data: Codable{
            var success: Bool
        }
        
        let semaphore = DispatchSemaphore (value: 0)
        guard let url = URL(string: "https://test-api.vladlink.ru/v1/public/additionalServices/\(OP)/\(person.publicUids[number])") else {
            print("url error")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("\(person.auth_token)", forHTTPHeaderField: "Authorization")
        
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
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                //let json = try JSONDecoder().decode(errorReceive.self, from: data)
                //print(json.error_message)
            } catch {
                print(error)
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
    }
    
    func statusCTV(number: Int){
        struct answerReceive: Codable{
            var status: Int
            var data: dataReceive
        }
        
        struct dataReceive: Codable{
            var status: Int
            var status_msg: String
        }
        
        let semaphore = DispatchSemaphore (value: 0)
        var request = URLRequest(url: URL(string: "https://test-api.vladlink.ru/v1/public/additionalServices/get-ctv/\(person.publicUids[number])")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("\(person.auth_token)", forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
               //let json = try JSONSerialization.jsonObject(with: data, options: [])
                self.tariff.productsITV.removeAll()
                let json = try JSONDecoder().decode(answerReceive.self, from: data)
                self.tariff.status_msg = json.data.status_msg
            } catch {
                print(error)
            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
    }
    
    func getDevices(){
        struct answerReceive: Codable{
            var status: Int
            var data: [dataReceive]
        }
        
        struct dataReceive: Codable{
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
        let semaphore = DispatchSemaphore (value: 0)
        var request = URLRequest(url: URL(string: "https://test-api.vladlink.ru/v1/devices")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("\(person.auth_token)", forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
            //  let json = try JSONSerialization.jsonObject(with: data, options: [])
            //   print(json)
             self.tariff.devices.removeAll()
             let json = try JSONDecoder().decode(answerReceive.self, from: data)
             for number in 0..<json.data.count{
                 self.tariff.addDevice.id = json.data[number].id
                 self.tariff.addDevice.device_name = json.data[number].device_name
                 self.tariff.addDevice.description = json.data[number].description
                 self.tariff.addDevice.cost = json.data[number].cost
                 self.tariff.addDevice.installment_plan = json.data[number].installment_plan
                 self.tariff.addDevice.installment_cost = json.data[number].installment_cost
                 self.tariff.addDevice.device_img = json.data[number].device_img
                 self.tariff.addDevice.order_descr = json.data[number].order_descr
                 self.tariff.addDevice.order_descr_installment = json.data[number].order_descr_installment
                 self.tariff.devices.append(self.tariff.addDevice)
             }
            } catch {
                print(error)
            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
    }
    
    func sendRequestDevice(number: Int, srv_type: Int, descr: String){
        struct answerReceive: Codable{
            var status: Int
            var data: dataReceive
        }
        
        struct dataReceive: Codable{
            var success: Bool
        }
        
        let semaphore = DispatchSemaphore (value: 0)
        guard let url = URL(string: "https://test-api.vladlink.ru/v1/devices/sendRequestOnBuy") else {
            print("url error")
            return
        }
        let parametrs = ["uid": person.publicUids[number], "srv_type": srv_type, "descr": descr] as [String : Any]
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
            } catch {
                print(error)
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
    }
}



