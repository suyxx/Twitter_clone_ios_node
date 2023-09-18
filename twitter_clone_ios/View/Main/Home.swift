//
//  Home.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 16/01/23.
//

import SwiftUI

struct Home: View {
    
    let user: User
    
    @State var selectedIndex = 0
    @State var showCreateTweet = false
    @State var text = ""
    
    var body: some View {
        VStack{
            ZStack{
                
                TabView {
                    Feed(user: user)
                        .onTapGesture {
                            self.selectedIndex = 0
                        }
                        .navigationBarHidden(true)
                        .tabItem{
                            if(selectedIndex == 0){
                                Image("home")
                                    .renderingMode(
                                        .template)
                                    .foregroundColor(Color("bg"))
                            }else{
                                Image("home")
                            }
                        
                        }
                        .tag(0)
                    SearchView()
                        .onTapGesture {
                            self.selectedIndex = 1
                        }.navigationBarHidden(true)
                        .tabItem{
                            if(selectedIndex != 1){
                                Image("search")
                                    .renderingMode(
                                        .template)
                                    .foregroundColor(Color("bg"))
                            }else{
                                Image("search")
                            }
                            
                        }
                        .tag(1)
                    NotificationsView()
                        .onTapGesture {
                            self.selectedIndex = 2
                        }.navigationBarHidden(true)
                        .tabItem{
                            if(selectedIndex != 2){
                                Image("notification")
                                    .renderingMode(
                                        .template)
                                    .foregroundColor(Color("bg"))
                            }else{
                                Image("notification")
                            }
                            
                        }
                        .tag(2)
                    MessagesView()
                        .onTapGesture {
                            self.selectedIndex = 3
                        }.navigationBarHidden(true)
                        .tabItem{
                            if(selectedIndex != 3){
                                Image("mail")
                                    .renderingMode(
                                        .template)
                                    .foregroundColor(Color("bg"))
                            }else{
                                Image("mail")
                            }
                            
                        }
                        .tag(3)
                }
                
              
                    
                    Spacer()
                    
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            Button(action: {
                                self.showCreateTweet.toggle()
                            }, label: {
                                Image("tweet_write")
                                    .renderingMode(.template)
                                    .resizable()
                                    .frame(width: 40, height: 20)
                                    .padding()
                                    .background(Color("bg"))
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                            })
                        }.padding()
                    }.padding(.bottom, 65)
                
            }
            .sheet(isPresented: $showCreateTweet, content: {
            CreateTweetView(show: $showCreateTweet, text: text)
            })
        }
    }
}


