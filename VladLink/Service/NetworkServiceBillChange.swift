//
//  NetworkServiceBillChange.swift
//  VladLink
//
//  Created by Svyatoslav Vladimirovich on 27.03.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import Foundation
import UIKit

class ChangeBill {
    let person = PersonModel.sharedData
    let bill = BillModel.sharedData
    
    func changeName(contact_id: String, newLabel: String) {
        struct answerReceive: Codable{
            var status: Int
            var data: dataReceive
        }
        
        struct dataReceive: Codable{
            var request_id: String
        }
        
        guard let url = URL(string: "https://test-api.vladlink.ru/v1/public/contacts/\(contact_id)") else {
            print("url error")
            return
        }
        let parametrs = ["label": newLabel]
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
    
    func deleteBill(contact_id: String){
        guard let url = URL(string: "https://test-api.vladlink.ru/v1/public/contacts/\(contact_id)") else {
            print("url error")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("\(person.auth_token)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        session.dataTask(with: request){(data, response, error)  in
            guard let httpResponse = response as? HTTPURLResponse, let _ = data
            else {
               print("error: not a valid http response")
               return
            }
            switch (httpResponse.statusCode) {
               case 200: //success response.
                  break
               case 400:
                  break
               default:
                  break
            }
           
        }.resume()
    }
}
