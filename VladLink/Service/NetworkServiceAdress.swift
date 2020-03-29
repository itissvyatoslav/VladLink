//
//  NetworkServiceAdress.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 27.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation


class NewAdress{
    let person = PersonModel.sharedData
    
    func showCitiesList(){
        struct answerReceive: Codable{
            var status: String
            var data: [dataReceive]
            var paginate: paginateReceive
        }
        
        struct dataReceive: Codable{
            var id: String
            var sname: String
        }
        
        struct paginateReceive: Codable{
            var count_page: Int
            var count_item: Int
        }
        
        var request = URLRequest(url: URL(string: "https://test-api.vladlink.ru/v1/address/cities")!,timeoutInterval: Double.infinity)
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
                //let json = try JSONDecoder().decode(answerReceive.self, from: data)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func showStreetList(city_id: String, streetName: String){
        struct answerReceive: Codable{
            var status: String
            var data: [dataReceive]
            var paginate: paginateReceive
        }
        
        struct dataReceive: Codable{
            var id: String
            var sname: String
        }
        
        struct paginateReceive: Codable{
            var count_page: Int
            var count_item: Int
        }
        
        var request = URLRequest(url: URL(string: "https://test-api.vladlink.ru/v1/address/streets?city_id=\(city_id)&name=\(streetName)&select=id%2Csname&order=sname&limit=20")!,timeoutInterval: Double.infinity)
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
                //let json = try JSONDecoder().decode(answerReceive.self, from: data)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func showBuildingList(street_id: String, buildingNumber: String){
        struct answerReceive: Codable{
            var status: String
            var data: [dataReceive]
            var paginate: paginateReceive
        }
        
        struct dataReceive: Codable{
            var id: String
            var dname: String
            var dcorp: String
        }
        
        struct paginateReceive: Codable{
            var count_page: Int
            var count_item: Int
        }
        
        var request = URLRequest(url: URL(string: "https://test-api.vladlink.ru/v1/address/doms?s_id=\(street_id)&name=\(buildingNumber)&select=id%2Cdname%2Cdcorp&order=dname%2Cdcorp&limit=20")!,timeoutInterval: Double.infinity)
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
                //let json = try JSONDecoder().decode(answerReceive.self, from: data)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func newAdress(did: String, flat: String, porch: String, floor: String){
        struct answerReceive: Codable{
            var status: String
            var data: dataReceive
        }
        
        struct dataReceive: Codable{
            var address: String
            var connect_id: String
            var state: Int
        }
        
        
        guard let url = URL(string: "https://test-api.vladlink.ru/v1/connecting/addConnectRequest") else {
            print("url error")
            return
        }
        let parametrs = ["did": did, "flat": flat, "porch": porch, "floor": floor, "phone": person.phoneNumber]
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
                //let json = try JSONDecoder().decode(answerReceive.self, from: data)
                let json = try JSONSerialization.jsonObject(with: data, options: [])// as! errorReceive
                //  if json.status == 200 {
                //   self.person.request_id = json.data.request_id
                //  }
                print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
    
}
