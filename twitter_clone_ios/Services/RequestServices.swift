//
//  RequestServices.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 16/02/23.
//

import Foundation

public class RequestServices {
    
    public static var requestDomain = "http://localhost:3000/"
    
    public static func postTweet(text: String, user: String, username: String, userId: String, completion: @escaping (_ result: [String: Any]?) -> Void){
        let params = ["text": text, "userId": userId, "user": user, "username": username] as [String : Any]
        let urlString = "tweets"
        let url = URL(string: requestDomain + urlString)!
        
        let session = URLSession.shared
        
        var request  = URLRequest(url: url)
        
        request.httpMethod = "POST"
        do{
            request.httpBody =  try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        }catch let error {
            print(error)
        }
        
        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")
        
        if let token = token {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request) { data, res, err in
            guard err == nil else {return}
            
            guard let data = data else {return}
            
            do{
                
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] {
                    completion(json)
                }
                
            }catch let error{
                print(error)
            }
        }
        
        task.resume()
        
    }
    
    
    static func fetchTweets(urlString: String, completion: @escaping (_ result: Result<Data?, NetworkError>) -> Void){
        print("fetchTweet service called")
        let url = URL(string: requestDomain + urlString)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request) { data, res, err in
            guard err == nil else {
                completion(.failure(.noData))
                return
            }
            
            guard let data = data else {return}
            
            completion(.success(data))
            
        }
        
        task.resume()
        
    }
    
    public static func followingProcess(urlString: String,id: String, completion: @escaping (_ result : [String: Any]?) -> Void){
        let url = URL(string: requestDomain + urlString)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        
        request.httpMethod = "PUT"
        
        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")!
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request) { data, res, err in
            guard err == nil else {
                return}
            
            guard let data = data else {
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]{
                    print(json)
                    completion(json)
                }
                
            }catch let error{
                print(error)
            }
        }
        task.resume()
    }
    
    public static func likeTweet(urlString: String, id: String, completion: @escaping (_ result: [String: Any]?) -> Void){
        let url = URL(string: requestDomain + urlString)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")!
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request) { data, res, err in
            guard err == nil else {return}
            
            guard let data = data else {return}
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any]{
                    completion(json)
                }
            }catch let error{
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
