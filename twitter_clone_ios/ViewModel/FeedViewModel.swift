//
//  FeedViewModel.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 12/03/23.
//

import Foundation

class FeedViewModel: ObservableObject {
    
    @Published var tweets = [Tweet]()
    
    init(){
        fetchTweets()
    }
    
    func fetchTweets(){
        RequestServices.fetchTweets(urlString: "tweets") { res in
            switch res {
                case .success(let data):
                    guard let tweets = try? JSONDecoder().decode([Tweet].self, from: data as! Data) else {return}
                
                    DispatchQueue.main.async {
                        self.tweets = tweets
                    }
                
                case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
