//
//  TweetCellViewModel.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 12/03/23.
//

import Foundation
import SwiftUI

class TweetCellViewModel: ObservableObject {
    @Published var tweet: Tweet
    @Published var user: User?
    let currentUser: User
    
    init(tweet: Tweet, currentUser: User){
        self.tweet = tweet
        self.currentUser = currentUser
        self.fetchUser(userId: tweet.user)
        checkIfUserLikedPost()
    }
    
    func fetchUser(userId: String){
        AuthService.fetchUser(id: userId) { res in
            switch res {
                case .success(let data):
                    guard let user = try? JSONDecoder().decode(User.self, from: data as! Data) else {return}
                    
                    DispatchQueue.main.async {
                        self.user = user
                    }
                case .failure(let err):
                                print(err.localizedDescription)
                                
                            
            }
        }
    }
    
    func like(){
        var urlString = "tweets/\(self.tweet.id)/like"
        RequestServices.likeTweet(urlString: urlString, id: self.tweet.id) { result in
            print("liked the tweet")
        }
        self.tweet.didLike = true
    }
    
    func unlike(){
        var urlString = "tweets/\(self.tweet.id)/unlike"
        RequestServices.likeTweet(urlString: urlString, id: self.tweet.id) { result in
            print("unliked the tweet")
        }
        self.tweet.didLike = false
    }
    func checkIfUserLikedPost(){
        if(self.tweet.likes.contains(self.currentUser.id)){
            self.tweet.didLike = true
        }else{
            self.tweet.didLike = false
        }
    }
    
    
}
