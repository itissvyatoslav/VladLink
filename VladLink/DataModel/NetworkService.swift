//
//  JSONParserAddPhoneVC.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 16.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation

class JSONAddPhoneVC{
    let person = PersonData.sharedData
    
    struct postMessageDataRequest: Codable {
        var data:  DataStruct?
        var status: Int
    }
    
    struct DataStruct: Codable {
        var phone: String?
        var requestid: String
        var code: String?
        
        enum CodingKeys: String, CodingKey{
            case phone
            case requestid = "request_id"
            case code
        }
    }
    
    func postPhoneRequest(phoneNumber: String){
        let queue = DispatchQueue.global()
        let parametr = ["phone": "\(phoneNumber)"]
        let parametrs = ["data": parametr]
        guard let url = URL(string: "https://test-api.vladlink.ru/v1/auth/subscribers/authByCall/request") else {
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
                        if json.status == 200 {
                            self.person.request_id = json.data!.requestid
                            self.person.callPhoneNumber = json.data!.phone!
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
    
    func postPhoneAuth(){
        let queue = DispatchQueue.global()
        let parametr = ["phone": "\(person.phoneNumber)"]
        let parametrs = ["data": parametr]
        guard let url = URL(string: "https://test-api.vladlink.ru/v1/auth/subscribers/authByCall/request") else {
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
                        if json.status == 200 {
                            self.person.request_id = json.data!.requestid
                            self.person.callPhoneNumber = json.data!.phone!
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
                        if json.status == 200 {
                            self.person.request_id = json.data!.requestid
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
        let parametr = ["phone": "\(phoneNumber)", "request_id": "\(request_id)", "code": "\(code)"]
        let parametrs = ["data": parametr]
        guard let url = URL(string: "https://test-api.vladlink.ru/v1/auth/subscribers/authByCode/check") else {
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
        print(parametrs)
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
                //      if json.status == 200 {
                //          self.person.request_id = json.data!.request_id
                //          self.person.callPhoneNumber = json.data!.phone!
                //      } else {
                //          print("status != 200")
                //      }
            } catch {
                print(error)
            }
        }.resume()
    }
}
