//
//  AuthService.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 28/01/23.
//

import Foundation
import SwiftUI

enum NetworkError: Error {
    case invalidURL
    case noData
    case decoadingError
}

enum AuthenticationError : Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

var baseUrl = "http://localhost:3000/"

public class AuthService{
    
    static func login(email: String, password: String, completion: @escaping (_ result: Result<Data?, AuthenticationError>) -> Void){
        print("Entered auth service")
        let urlString = "users/login"
        do{
           try makeRequest(urlString: urlString, reqBody: ["email": email, "password": password]){res in
                print("got request response")
                switch res {
                case .success(let data):
                    print(data)
                    completion(.success(data))
                case .failure(let error):
                    print(error)
                    completion(.failure(.invalidCredentials))
                    
                }
            }
        }catch let error{
            print(error)
        }
    }
        
        
        
        
        static func register(email: String, username: String, password: String, name: String, completion: @escaping (_ result: Result<Data?, AuthenticationError>) -> Void){
            let urlString = "users"
            
            
            
            makeRequest(urlString: urlString, reqBody: ["email": email, "username": username, "password": password, "name": name]) {result in
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(.invalidCredentials))
                }
            }
        }
    
            
            
            
            static func makeRequest(urlString: String, reqBody: [String: Any], completion: @escaping (_ result: Result<Data?, NetworkError>) -> Void){
                print("entered makeRequest")
                let url = URL(string: baseUrl+urlString)!
                print(url)
                let session = URLSession.shared
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                print(request)
                do{
                    request.httpBody = try JSONSerialization.data(withJSONObject: reqBody, options: .prettyPrinted) }catch let error{
                    print(error)
                }
                print(request)
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                
                let task = session.dataTask(with: request) { data, res, err in
                    
                    guard err == nil else {
                        return
                    }
                    
                    guard let data = data else {
                        completion(.failure(.noData))
                        return
                    }
                    
                    
                    do{
                        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers){
                            print(json)
                        }
                        print("printing data")
                        print(data)
                        completion(.success(data))
                    }catch let error {
                        completion(.failure(.decoadingError))
                        print(error)
                    }
                }
                
                task.resume()
            }
    
    // Fetch user Function
    static func fetchUser(id: String, completion: @escaping(_ result: Result<Data, AuthenticationError>) -> Void){
        
        let urlString = "users/\(id)"
        let url = URL(string: baseUrl+urlString)!
        var urlRequest = URLRequest(url: url)
        
        let session = URLSession.shared
        
        urlRequest.httpMethod = "GET"
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: urlRequest) { data, res, err in
            guard err == nil else {
                return
            }
            
            guard let data = data else {
                return completion(.failure(.invalidCredentials))
            }
            
            completion(.success(data))
            
            do {
                if let json  = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    
                }
            }
            
            catch let err {
                completion(.failure(.invalidCredentials))
            }
        }
        
        task.resume()
        
        
    }
    
    //Fetch all user Function
    static func fetchAllUser(completion: @escaping(_ result: Result<Data, AuthenticationError>) -> Void){
        
        let url = URL(string: "http://localhost:3000/users")!
        var urlRequest = URLRequest(url: url)
        
        let session = URLSession.shared
        
        urlRequest.httpMethod = "GET"
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: urlRequest) { data, res, err in
            guard err == nil else {
                return
            }
            
            guard let data = data else {
                return completion(.failure(.invalidCredentials))
            }
            
            completion(.success(data))
            
            do {
                if let json  = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    
                }
            }
            
            catch let err {
                completion(.failure(.invalidCredentials))
            }
        }
        
        task.resume()
        
        
    }
    
    
    static func makePatchRequestWithAuth(urlString: String, reqBody: [String : Any], completion: @escaping (_ result : Result<Data?, NetworkError>) -> Void){
        let session = URLSession.shared
        let url = URL(string: baseUrl+urlString)!
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        do{
            print(reqBody)
            request.httpBody = try JSONSerialization.data(withJSONObject: reqBody, options: .prettyPrinted)
        }catch let error {
            print("error occured: \(error)")
        }
        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")!
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: request) { data, res, err in
            guard err == nil else {return}
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(data))
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] {
                    
                }
            }catch let error{
                
                completion(.failure(.decoadingError))
                print(error)
            }
        }
        
        task.resume()
    }
}
    
    
