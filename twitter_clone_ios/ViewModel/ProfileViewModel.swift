//
//  ProfileViewModel.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 14/03/23.
//

import SwiftUI

class ProfileViewModel : ObservableObject {
    @Published var user : User
    @Published var tweets = [Tweet]()
    
    init(user: User) {
        self.user = user
        fetchTweets()
        checkIfCurrentUserIsUser()
        checkIfUserIsFollowed()
    }
    
    func fetchTweets(){
        print("fetchTweet ViewModel called")
        RequestServices.fetchTweets(urlString: "tweets/\(self.user.id)") { res
            in
            switch res {
                case .success(let data):
                    guard let tweets = try? JSONDecoder().decode([Tweet].self, from: data as! Data) else { return }
                    DispatchQueue.main.async {
                        self.tweets = tweets
                    }
                case .failure(let error):
                print(error.localizedDescription)
                
            
                
            }
        }
    }
    
    func checkIfCurrentUserIsUser(){
        if (self.user.id == AuthViewModel.shared.currentUser!.id){
            self.user.isCurrentUser = true
        }else{
            self.user.isCurrentUser = false
        }
    }
    
    func follow(){
        let url = "users/\(self.user.id)/follow"
        RequestServices.followingProcess(urlString: url, id: self.user.id) { res in
            print(res)
            print("Followed")
        }
        self.user.isFollowed = true
    }
    
    func unfollow(){
        let url = "users/\(self.user.id)/unfollow"
        RequestServices.followingProcess(urlString: url, id: self.user.id) { res in
            print(res)
            print("Un Followed")
        }
        self.user.isFollowed = false
    }
    
    func checkIfUserIsFollowed(){
        if(self.user.followers.contains(AuthViewModel.shared.currentUser!.id)){
            self.user.isFollowed = true
        }else{
            self.user.isFollowed = false
        }
    }
}
