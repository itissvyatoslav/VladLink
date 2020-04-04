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
    
    func productServicesList(account_id: String){
        let semaphore = DispatchSemaphore (value: 0)
        var request = URLRequest(url: URL(string: "https://test-api.vladlink.ru/v1/online/product_services/\(account_id)")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("\(person.auth_token)", forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
               let json = try JSONSerialization.jsonObject(with: data, options: [])
               print(json)
               // let json = try JSONDecoder().decode(answerReceive.self, from: data)
                //print("build succes")
            } catch {
                print(error)
            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
    }
}

