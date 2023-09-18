//
//  SearchViewModel.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 16/03/23.
//

import SwiftUI

class SearchViewModel : ObservableObject {
    
    @Published var users = [User]()
    
    init() {
        fetchUser()
    }
    
    func fetchUser(){
        AuthService.fetchAllUser { result in
            switch result {
                case .success(let data):
                    guard let users = try? JSONDecoder().decode([User].self, from: data as! Data) else {return}
                    DispatchQueue.main.async {
                        self.users = users
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func filterUsers(_ query: String) -> [User]{
        let lowerCaseQuery = query.lowercased()
        return users.filter({
            ($0.name?.lowercased().contains(lowerCaseQuery))! || $0.username.lowercased().contains(lowerCaseQuery)
            
        })
    }
}
