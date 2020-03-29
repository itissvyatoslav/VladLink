//
//  NetworkServiceAccount.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 19.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation

class JSONService{
    let person = PersonModel.sharedData
    let billLoaded = BillModel.sharedData
    
    //MARK: - STRUCT
    struct requestBill: Codable {
        var data: [bill?]
        var paginate: paginateStruct
        var status: Int
    }
    
    struct bill: Codable {
        var balls: String
        var bill: String
        var block: Bool
        var city_id: String
        var email: String?
        var full_name: String
        var id: String
        var is_juridical: Bool
        var is_sms: [String]
        var skidko: String
        var tariff: String
        var tariff_current: tariffCurrent
        var tariff_next: String
        var u_address: [uAddress]
        var ulogin: String
    }
    
    struct tariffCurrent: Codable{
        var abonpay: String
        var tid: String
        var tname: String
    }
    
    struct uAddress: Codable {
        var descr: String
        var did: String
        var dom_name: String
        var floor: String?
        var porch: String
    }
    
    struct paginateStruct: Codable{
        var count_item: Int
        var count_page: Int
    }
 //MARK: - STRUCT
    struct errorReceive: Codable {
        var error_message: String
        var status: Int
    }
    
    func setEntry(){
        guard let url = URL(string: "https://test-api.vladlink.ru/v1/mobile_application/add_history_entry/\(person.uid)") else {
            print("url error")
            return
        }
        let parametrs = ["device_token": (person.uid), "token_type": "2"]
        let parametr = ["data": parametrs]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
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
                let json = try JSONDecoder().decode(errorReceive.self, from: data)
               // let json = try JSONSerialization.jsonObject(with: data, options: []) as! errorReceive
       //   if json.status == 200 {
       //      self.person.auth_token = (json.data?.auth_token)!
       //      self.person.uid = (json.data?.uid)!
       //      self.person.name = (json.data?.name)!
       //      self.person.publicUids = (json.data!.public_uids) as! [String]
       //   }
                print("!!!!! ---- \(json.error_message)")
                
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getBills(auth_token: String){
        var semaphore = DispatchSemaphore (value: 0)
        
        var request = URLRequest(url: URL(string: "https://test-api.vladlink.ru/v1/public/users/my")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(auth_token, forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
            }
            do {
                let json = try JSONDecoder().decode(requestBill.self, from: data)
                print("!!!!!!!!!!!!!!!!!!!!!!\(json)")
               //let json = try JSONSerialization.jsonObject(with: data, options: [])
                for number in 0..<json.data.count {
                    self.billLoaded.addedBill.balls = (json.data[number]?.balls)!
                    self.billLoaded.addedBill.bill = (json.data[number]?.bill)!
                    self.billLoaded.addedBill.block = (json.data[number]?.block)!
                    self.billLoaded.addedBill.city_id = (json.data[number]?.city_id)!
                    self.billLoaded.addedBill.email = (json.data[number]?.email)
                    self.billLoaded.addedBill.full_name = (json.data[number]?.full_name)!
                    self.billLoaded.addedBill.id = (json.data[number]?.id)!
                    self.billLoaded.addedBill.is_juridical = (json.data[number]?.is_juridical)!
                    self.billLoaded.addedBill.is_sms = json.data[number]!.is_sms
                    self.billLoaded.addedBill.skidko = json.data[number]!.skidko
                    self.billLoaded.addedBill.tariff = json.data[number]!.tariff
                    self.billLoaded.addedBill.tariff_current.abonpay = json.data[number]!.tariff_current.abonpay
                    self.billLoaded.addedBill.tariff_current.tid = json.data[number]!.tariff_current.tid
                    self.billLoaded.addedBill.tariff_current.tname = json.data[number]!.tariff_current.tname
                    self.billLoaded.addedBill.u_address[0].descr = json.data[number]!.u_address[0].descr
                    self.billLoaded.addedBill.u_address[0].did = json.data[number]!.u_address[0].did
                    self.billLoaded.addedBill.u_address[0].dom_name = json.data[number]!.u_address[0].dom_name
                    self.billLoaded.addedBill.u_address[0].floor = json.data[number]!.u_address[0].floor
                    self.billLoaded.addedBill.u_address[0].porch = json.data[number]!.u_address[0].porch
                    self.billLoaded.addedBill.ulogin = json.data[0]!.ulogin
                    self.billLoaded.bills.append(self.billLoaded.addedBill)
                }
                //print(json.error_message)
            } catch {
                print(error)
            }
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
    }
}
