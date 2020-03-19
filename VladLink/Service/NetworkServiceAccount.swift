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
    let bill = BillModel.sharedData
    
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
        var u_address :[uAddress]
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
                //let json = try JSONSerialization.jsonObject(with: data, options: [])
                self.bill.bills = json.data
                print(json.data)
            } catch {
                print(error)
            }
            //print(String(data: data, encoding: .utf8)!)
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
    }
}
