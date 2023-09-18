//
//  SlideMenu.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 18/01/23.
//

import SwiftUI
import Kingfisher

struct SlideMenu: View {
    
    @ObservedObject var viewModel : AuthViewModel
    
    @State var show = false
    
    var menuButtons = ["Profile", "Lists", "Topics", "Bookmarks", "Moments"]
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var width = UIScreen.main.bounds.width
    
    var body: some View {
        VStack{
            HStack(spacing: 0, content: {
                
                VStack(alignment: .leading,  content: {
                    NavigationLink(destination: UserProfile(user: viewModel.currentUser!)){
                        KFImage(URL(string: "http://localhost:3000/users/\(self.viewModel.currentUser!.id)/avatar"))
                            .placeholder({
                                Image("Profile")
                                    .resizable()
                            })
                            .resizable()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                        
                    }
                    
                    HStack(alignment: .top, spacing: 12 ,content: {
                        VStack(alignment: .leading,
                               spacing: 12, content: {
                            NavigationLink(destination: UserProfile(user: viewModel.currentUser!)){
                                Text(viewModel.currentUser!.name!)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                            }
                            
                            NavigationLink(destination: UserProfile(user: viewModel.currentUser!)){
                                Text("@\(viewModel.currentUser!.username)")
                                    .foregroundColor(.gray)
                            }
                            
                            HStack(spacing: 20, content: {
                                FollowView(count: 23, title: "Following")
                                FollowView(count: 13, title: "Followers")
                            })
                            .padding(.top, 10)
                            Divider()
                                .padding(.top, 10)
                        })
                        
                        Spacer(minLength: 0)
                        
                        Button(action: {
                            withAnimation{
                                self.show.toggle()
                            }
                        }, label: {
                            Image(systemName: show ? "chevron.down" : "chevron.up")
                                .foregroundColor(Color("bg"))
                            
                        })
                        
                    })
                    
                    
                    VStack(alignment: .leading, content: {
                        ForEach(menuButtons, id:\.self){
                            item in
                            NavigationLink(destination: UserProfile(user: viewModel.currentUser!)){
                                MenuButton(title: item)
                            }
                        }
                        
                        Divider()
                            .padding(.top)
                        
                        Button(action: {}, label: {
                            MenuButton(title: "Twitter Ads")
                        })
                        
                        Divider()
                            .padding(.top)
                        
                        Button(action: {}, label: {
                            Text("Settings and privacy")
                                .foregroundColor(.black)
                        })
                        .padding(.top, 20)
                        
                        Button( action: {}, label: {
                            Text("Help center")
                                .foregroundColor(.black)
                        })
                        
                        Spacer(minLength: 0)
                        
                        Divider()
                            .padding(.bottom)
                        
                        HStack {
                            Button(
                                action: {}, label: {
                                    Image("help")
                                        .renderingMode(.template)
                                        .resizable()
                                        .frame(width: 26, height: 26)
                                        .foregroundColor(Color("bg"))
                                    
                                    
                                })
                            
                            Spacer()
                            
                            Image("barcode")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 26, height: 26)
                                .foregroundColor(Color("bg"))
                        }
                    })
                    .opacity(show ? 1: 0)
                    .frame(height:  show ? nil: 0)
                    
                    VStack(alignment: .leading){
                        Button(action: {}, label: {
                            Text("Create a new account")
                                .foregroundColor(Color("bg"))
                        })
                        
                        Button(action: {}, label: {
                            Text("Add an existing account")
                                .foregroundColor(Color("bg"))
                        })
                        
                        Spacer(minLength: 0)
                        
                    }
                    .opacity(!show ? 1:0)
                    .frame(height: !show ? nil:0)
                    
                    
                })
                .padding(.horizontal, 30)
                .padding(.top, edges?.top == 0 ? 15 : edges?.top)
                .padding(.bottom, edges?.bottom == 0 ? 15 : edges?.bottom)
                
                .frame(width: width-60)
                .background(Color.white)
                .ignoresSafeArea(.all, edges: .vertical)
                
                Spacer(minLength: 0)
            })
        }
    }
}


