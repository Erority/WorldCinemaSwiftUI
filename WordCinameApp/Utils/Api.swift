//
//  Api.swift
//  WordCinameApp
//
//  Created by Денис Большачков on 10.03.2022.
//

import Foundation

class Api {
    
    static var API_ADDRESS = "http://cinema.areas.su/"
    
    func postUser(userData: PostUserDataForReg){
        let semaphore = DispatchSemaphore (value: 0)
        
        let parameters = "{\n  \"email\": \"\(userData.email)\",\n  \"password\": \"\(userData.password)\",\n  \"firstName\": \"\(userData.firstName)\",\n  \"lastName\": \"\(userData.lastName)\"\n}"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "http://cinema.areas.su/auth/register")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                semaphore.signal()
                return
            }
            print(String(data: data, encoding: .utf8)!)
            semaphore.signal()
        }
        
        
        task.resume()
        semaphore.wait()
        
    }
    
    func authUser(userData: PostUserDataForAuth, completion: @escaping  (PostUserDataForAuthRecieveData) -> ()) {
        let semaphore = DispatchSemaphore (value: 0)
        
        let parameters = "{\n  \"email\": \"vasya@mail.com\",\n  \"password\": \"qwerty\"\n}"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "http://cinema.areas.su/auth/login")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                semaphore.signal()
                return
            }
            
            let jsonResponse = try! JSONDecoder().decode(PostUserDataForAuthRecieveData.self, from: data)
                        completion(jsonResponse)
            
            
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
    }
}
