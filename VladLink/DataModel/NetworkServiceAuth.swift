//
//  JSONParserAddPhoneVC.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 16.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation

class JSONAddPhoneVC{
    let person = PersonModel.sharedData
    
    struct postMessageDataRequest: Codable {
        var data:  DataStructRequest?
        var status: Int
    }
    
    struct DataStructRequest: Codable {
        var phone: String?
        var requestid: String?
        var code: String?
        enum CodingKeys: String, CodingKey{
            case phone
            case requestid = "request_id"
            case code
        }
    }
    
    struct postMessageDataAuth: Codable {
        var data: DataStructAuth?
        var status: Int
    }
    
    struct DataStructAuth: Codable {
        var phone: String?
        var requestid: String?
        var code: String?
        var auth_token: String?
        var name: String?
        var uid: String?
        var public_uids = [String?]()
        
        enum CodingKeys: String, CodingKey{
            case phone
            case requestid = "request_id"
            case code
            case auth_token
            case name
            case uid
            case public_uids
            
        }
    }
    
    func postPhoneRequest(phoneNumber: String){
        var semaphore = DispatchSemaphore (value: 0)
        
        let parametr = ["phone": "\(phoneNumber)"]
        let parametrs = ["data": parametr]
        guard let url = URL(string: "https://test-api.vladlink.ru/v1/auth/subscribers/authByCall/request") else {
            print("error url")
            return
        }
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
                
                let json = try JSONDecoder().decode(postMessageDataRequest.self, from: data)
                if json.status == 200 {
                    self.person.request_id = json.data!.requestid!
                    self.person.callPhoneNumber = json.data!.phone!
                    semaphore.signal()
                } else {
                    print("status != 200")
                }
            } catch {
                print(error)
            }
        }.resume()
        semaphore.wait()
        return
    }
    
    func postPhoneAuth(){
        var semaphore = DispatchSemaphore (value: 0)
        let queue = DispatchQueue.global()
        let parametr = ["phone": "\(person.phoneNumber)", "request_id": "\(person.request_id)"]
        let parametrs = ["data": parametr]
        guard let url = URL(string: "https://test-api.vladlink.ru/v1/auth/subscribers/authByCall/request") else {
            print("error url")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parametrs, options: []) else {
            print("JSONSerialization error")
            return
        }
        request.httpBody = httpBody
        
        queue.sync {
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
                    let json = try JSONDecoder().decode(postMessageDataAuth.self, from: data)
                    if json.status == 200 {
                        self.person.auth_token = (json.data?.auth_token)!
                        self.person.uid = (json.data?.uid)!
                        self.person.name = (json.data?.name)!
                        self.person.publicUids = (json.data!.public_uids) as! [String]
                        semaphore.signal()
                    } else {
                        print("status != 200")
                    }
                } catch {
                    print(error)
                }
            }.resume()
            semaphore.wait()
        }
    }
    
    func postMessageRequest(phoneNumber: String){
        let queue = DispatchQueue.global()
        let parametr = ["phone": "\(phoneNumber)"]
        let parametrs = ["data": parametr]
        guard let url = URL(string: "https://test-api.vladlink.ru/v1/auth/subscribers/authByCode/request") else {
            print("error url")
            return
        }
        queue.sync {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parametrs, options: []) else {
                print("JSONSerialization error")
                return
            }
            request.httpBody = httpBody
            
            queue.sync {
                
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
                        
                        let json = try JSONDecoder().decode(postMessageDataRequest.self, from: data)
                        print(json)
                        if json.status == 200 {
                            self.person.request_id = json.data!.requestid!
                        } else {
                            print("status != 200")
                        }
                    } catch {
                        print(error)
                    }
                }.resume()
            }
        }
    }
    
    func postMessageAuth(phoneNumber: String, request_id: String, code: String) {
        var semaphore = DispatchSemaphore (value: 0)
        
        guard let url = URL(string: "https://test-api.vladlink.ru/v1/auth/subscribers/authByCode/check") else {
            print("url error")
            return
        }
        let parametrs = ["phone": phoneNumber, "request_id": request_id, "code": code]
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
                let json = try JSONDecoder().decode(postMessageDataAuth.self, from: data)
                //let json = try JSONSerialization.jsonObject(with: data, options: []) as! postMessageDataAuth
                if json.status == 200 {
                    self.person.auth_token = (json.data?.auth_token)!
                    self.person.uid = (json.data?.uid)!
                    self.person.name = (json.data?.name)!
                    self.person.publicUids = (json.data!.public_uids) as! [String]
                    semaphore.signal()
                }
                //print("!!!!! ---- \(json)")
                
            } catch {
                print(error)
            }
        }.resume()
        semaphore.wait()
    }
}
