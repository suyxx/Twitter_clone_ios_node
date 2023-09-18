//
//  TweetCellView.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 18/01/23.
//

import SwiftUI
import Kingfisher

struct TweetCellView: View {
    
    @ObservedObject var viewModel: TweetCellViewModel
    var didLike: Bool {
        return viewModel.tweet.didLike ?? false
    }
    
    init(viewModel: TweetCellViewModel){
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack{
            HStack(alignment: .top, spacing: 10, content: {
                if let user = viewModel.user {
                    NavigationLink(destination: UserProfile(user: user)) {
                        KFImage(URL(string: "http://localhost:3000/users/\(self.viewModel.tweet.userID)/avatar"))
                            .placeholder({
                                Image("Profile")
                                    .resizable()
                            })
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 55, height: 55)
                            .clipShape(Circle())
                    }
                }
                
                VStack(alignment: .leading,spacing: 10) {
                    (
                        Text("\(self.viewModel.tweet.username)")
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        +
                        Text("@\(self.viewModel.tweet.username)")
                            .foregroundColor(.gray)
                    )
                    
                    Text(self.viewModel.tweet.text)
                        .frame(maxHeight: 100, alignment: .top)
                    
                    if let imageId = viewModel.tweet.id {
                        if viewModel.tweet.image == "true" {
                            GeometryReader { proxy in
                                KFImage(URL(string: "http://localhost:3000/tweets/\(imageId)/image"))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: proxy.frame(in: .global).width, height: 250)
                                    .cornerRadius(15)
                            }
                            .frame(height: 250)
                        }
                    }
                    
                    HStack(spacing: 30, content: {
                        Button(action: {}, label: {
                            Image("comment")
                                .resizable()
                                .frame(width: 16, height: 16)
                        }).foregroundColor(.gray)
                        Button(action: {}, label: {
                            Image("retweet")
                                .resizable()
                                .frame(width: 16, height: 16)
                        }).foregroundColor(.gray)
                        
                        Button(action: {
                            if(self.didLike){
                                self.viewModel.unlike()
                            }else{
                                self.viewModel.like()
                            }
                        }, label: {
                            if(self.didLike == false){
                                Image("like")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                            }else{
                                Image("like").resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(.red)
                                    .frame(width: 16, height: 16)
                                    
                            }
                        }).foregroundColor(.gray)
                        
                        Button(action: {}, label: {
                            Image("share")
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 16, height: 16)
                        }).foregroundColor(.gray)
                            
                    })
                    .padding(.top, 4)
                    
                }
                
                Spacer()
                
                })
                
                
            
            
            
        }
    }
}


var sampleText = "Hi this is my first tweet hope you all guys are doing fine and living your life to full. Hi this is my first tweet hope you all guys are doing fine and living your life to full. Hi this is my first tweet hope you all guys are doing fine and living your life to full. "
