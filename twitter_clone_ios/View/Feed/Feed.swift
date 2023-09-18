//
//  Feed.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 16/01/23.
//

import SwiftUI

struct Feed: View {
    
    @ObservedObject var viewModel = FeedViewModel()
    let user: User
    
    var body: some View {
        RefreshableScrollView(content:
            ScrollView(.vertical,showsIndicators: false, content: {
                LazyVStack(spacing: 18){
                    ForEach(viewModel.tweets){
                        tweet in
                        TweetCellView(viewModel: TweetCellViewModel(tweet: tweet, currentUser: user))
                        Divider()
                    }
                }
                .padding(.top)
                .padding(.horizontal)
                .zIndex(0)
                
            })
        ) { control in
            DispatchQueue.main.async {
                self.viewModel.fetchTweets()
                control.endRefreshing()
            }
        }
    }
}


