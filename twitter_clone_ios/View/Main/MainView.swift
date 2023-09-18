//
//  MainView.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 18/01/23.
//

import SwiftUI

struct MainView: View {
    
    let user : User
    
    @State var width = UIScreen.main.bounds.width - 60
    @State var x = -UIScreen.main.bounds.width + 60
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                    VStack{
                        TopBar(x: $x)
                        Home(user: user)
                    }
                    
                    SlideMenu(viewModel: AuthViewModel.shared)
                        .shadow(color: Color.black.opacity(x != 0 ? 0.1 : 0), radius: 5, x: 5, y: 5)
                        .offset(x: x)
                        .background(Color.black.opacity(x == 0 ? 0.5: 0))
                        .ignoresSafeArea(.all, edges: .vertical)
                        .onTapGesture {
                            withAnimation{
                                x = -width
                            }
                        }
                }.gesture(DragGesture().onChanged({
                    (value) in
                    withAnimation{
                        if value.translation.width > 0{
                            if x < 0 {
                                x = -width + value.translation.width
                            }
                        }else{
                            if x != width {
                                x = value.translation.width
                            }

                        }
                    }
                }).onEnded({(value) in
                    withAnimation{
                        if -x < width / 2 {
                            x = 0
                        }else{
                            x = -width
                        }
                    }
                }))
            }.navigationBarHidden(true)
                .navigationTitle("")
        }
    }
}

