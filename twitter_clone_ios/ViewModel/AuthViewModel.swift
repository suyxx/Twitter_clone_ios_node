//
//  AuthViewModel.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 27/01/23.
//

import SwiftUI

class AuthViewModel: ObservableObject {
    
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: User?
    
    init(){
        let defaults  = UserDefaults.standard
        let token = defaults.object(forKey: "jsonwebtoken")
        
        if token != nil {
            isAuthenticated = true
            if let userId = defaults.object(forKey: "userid"){
                self.fetchUser(userId: userId as! String)
            }else {
                print("user id not found")
            }
            
        }else{
            isAuthenticated = false
        }
    }
    
    static let shared = AuthViewModel()
    
    func login(email: String, password: String){
        print("login called")
        let defaults = UserDefaults.standard
        
        AuthService.login(email: email, password: password) { result in
            print("got auth result \(result)")
            switch result {
                case .success(let data):
                    guard let user = try? JSONDecoder().decode(ApiResponse.self, from: data!) else  {
                        
                    if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any] {
                            print(json)
                    }
                            
                    return print("user not found")
                        
                    }

                    DispatchQueue.main.async {
                        defaults.set(user.token, forKey: "jsonwebtoken")
                        defaults.set(user.user.id, forKey: "userid")
                        self.isAuthenticated = true
                        self.currentUser = user.user
                    }
                
                case .failure(let error):
                    print(error.localizedDescription)
                            
            }
        }
    }
    
    func register(name: String, username: String, email: String, password: String){
        AuthService.register(email: email, username: username, password: password, name: name) { result in
            switch result {
            case .success(let data):
                guard let user = try? JSONDecoder().decode(ApiResponse.self, from: data!) else {
                    return
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    func fetchUser(userId: String){
        AuthService.fetchUser(id: userId) { result in
            print(result)
            switch result {
                case .success(let data):
                    guard let user = try? JSONDecoder().decode(User.self, from: data as! Data) else {
                        return
                    }
                    DispatchQueue.main.async {
                        UserDefaults.standard.setValue(user.id, forKey: "userid")
                        self.isAuthenticated = true
                        self.currentUser = user
                        print(user)
                    }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func logout(){
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach{ key in
            defaults.removeObject(forKey: key)
        }
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
        
    }
}
