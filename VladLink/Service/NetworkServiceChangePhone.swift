//
//  NetworkServiceChangePhone.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 24.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation

class ChangePhoneNumber {
    let person = PersonModel.sharedData
    
    struct errorReceive: Codable {
        var error_message: String
        var status: Int
    }
    
    func postMessageRequest(phoneNumber: String){
        
        struct answerReceive: Codable{
            var status: Int
            var data: dataReceive
        }
        
        struct dataReceive: Codable{
            var request_id: String
        }
        
        guard let url = URL(string: "https://test-api.vladlink.ru/v1/auth/subscribers/checkPhoneByCode/request") else {
            print("url error")
            return
        }
        let parametrs = ["phone": phoneNumber]
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
                // let json = try JSONSerialization.jsonObject(with: data, options: []) as! errorReceive
                   if json.status == 200 {
                    self.person.request_id = json.data.request_id
                   }
                
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func postMessageAuth(code: String){
        struct answerReceive: Codable{
            var status: Int
            var data: dataReceive
        }
        
        struct dataReceive: Codable{
            var answer: String
        }
        
        guard let url = URL(string: "https://test-api.vladlink.ru/v1/auth/subscribers/checkPhoneByCode/check") else {
            print("url error")
            return
        }
        let parametrs = ["phone": person.maybePhoneNumber, "request_id": person.request_id, "code": code]
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
                // let json = try JSONSerialization.jsonObject(with: data, options: [])// as! errorReceive
                //   if json.status == 200 {
                 //   self.person.request_id = json.data.request_id
                  // }
                print(json.data.answer)
                
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func postPhoneRequest(phoneNumber: String){
        let semaphore = DispatchSemaphore (value: 0)
        struct answerReceive: Codable{
            var status: Int
            var data: dataReceive
        }
        
        struct dataReceive: Codable{
            var phone: String
            var request_id: String
        }
        
        guard let url = URL(string: "https://test-api.vladlink.ru/v1/auth/subscribers/checkPhoneByCall/request") else {
            print("url error")
            return
        }
        let parametrs = ["phone": phoneNumber]
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
                //let json = try JSONSerialization.jsonObject(with: data, options: []) as! errorReceive
                print(json)
                  if json.status == 200 {
                    self.person.request_id = json.data.request_id
                    self.person.callPhoneNumber = json.data.phone
                  }
                
            } catch {
                print(error)
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
    }
    
    func postPhoneAuth(){
        struct answerReceive: Codable{
            var status: Int
            var data: dataReceive
        }
        
        struct dataReceive: Codable{
            var answer: String
        }
        
        let semaphore = DispatchSemaphore (value: 0)
        guard let url = URL(string: "https://test-api.vladlink.ru/v1/auth/subscribers/checkPhoneByCall/check") else {
            print("url error")
            return
        }
        let parametrs = ["phone": person.maybePhoneNumber, "request_id": person.request_id]
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
                print(json.data.answer)
                
            } catch {
                print(error)
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
    }
    
    func updatePhone(){
        
        struct answerReceive: Codable{
            var status: Int
            var data: dataReceive
        }
        
        struct dataReceive: Codable{
            var uid: String
            var name: String
            var auth_token: String
            var public_uids: [String]
            var phone: String
        }
        
        let semaphore = DispatchSemaphore (value: 0)
        guard let url = URL(string: "https://test-api.vladlink.ru/v1/public/contacts/updateMyMainPhone") else {
            print("url error")
            return
        }
        let parametrs = ["phone": person.maybePhoneNumber, "oldPhone": person.phoneNumber]
        let parametr = ["data": parametrs]
        print("New: \(person.maybePhoneNumber), old: \(person.phoneNumber)")
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
