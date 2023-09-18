//
//  WelcomeView.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 19/01/23.
//

import SwiftUI

struct WelcomeView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel

    @State var width = UIScreen.main.bounds.width
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer(minLength: 0)
                    
                    Image("twitter_logo_blue")
                        .resizable()
                        .scaledToFill()
                        .padding(.trailing)
                        .frame(width: 60, height: 60)
                    
                    Spacer()
                }
                
                Spacer(minLength: 0)
                
                Text("See what's happening in the world right now.")
                    .font(.system(size: 30, weight: .heavy, design: .default))
                    .frame(width: (getRect().width * 0.9),alignment: .center )
                Spacer(minLength: 0)
                
                VStack(alignment: .center, content: {
                    
                    Button(action: {
                        print("Sign in with Google")
                    }, label: {
                        HStack(spacing: -4, content: {
                            Image("google")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 25, height: 25)
                            
                            Text("Continue with Google")
                                .fontWeight(.bold)
                                .font(.title3)
                                .foregroundColor(.black)
                                .padding()
                        })
                        .overlay(
                            RoundedRectangle(cornerRadius: 36)
                                .stroke(Color.black, lineWidth: 1)
                                .opacity(0.3)
                                .frame(width: 320, height: 60, alignment: .center)
                        )
                    })
                    
                    Button(action: {
                        print("Sign in with Google")
                    }, label: {
                        HStack(spacing: -4, content: {
                            Image("apple")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 25, height: 25)
                            
                            Text("Continue with Apple")
                                .fontWeight(.bold)
                                .font(.title3)
                                .foregroundColor(.black)
                                .padding()
                        })
                        .overlay(
                            RoundedRectangle(cornerRadius: 36)
                                .stroke(Color.black, lineWidth: 1)
                                .opacity(0.3)
                                .frame(width: 320, height: 60, alignment: .center)
                        )
                    })
                    
                    HStack{
                        Rectangle()
                            .foregroundColor(.gray)
                            .opacity(0.3)
                            .frame(width: (getRect().width * 0.35), height: 1)
                        Text("Or")
                            .foregroundColor(.gray)
                        Rectangle()
                            .foregroundColor(.gray)
                            .opacity(0.3)
                            .frame(width: (getRect().width * 0.35), height: 1)
                    }
                    
                    NavigationLink(destination: RegisterView().navigationBarHidden(true)) {
                        RoundedRectangle(cornerRadius: 36)
                            .foregroundColor(Color(red: 29/255, green: 161 / 255, blue: 242 / 255))
                            .frame(width: 320, height: 60, alignment: .center)
                            .overlay(
                                Text("Create Account")
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .padding()
                            )
                    }
                    
                }).padding()
                
                VStack(alignment: .leading) {
                    VStack{
                        Text("By signing up, you agree to our ")
                        + Text("Terms")
                            .foregroundColor(Color(red: 29/255, green: 161 / 255, blue: 242 / 255))
                        + Text(", ") + Text("Privacy Policy ").foregroundColor(Color(red: 29/255, green: 161 / 255, blue: 242 / 255))
                        + Text(", Cookie Use")
                            .foregroundColor(Color(red: 29/255, green: 161 / 255, blue: 242 / 255))
                        
                        
                    }
                    .padding(.bottom)
                    
                    HStack(spacing: 2){
                        Text("Have an account already? ")
                        NavigationLink(destination: LoginView().navigationBarHidden(true), label: {
                            Text("Log in")
                                .foregroundColor(Color(red: 29/255, green: 161 / 255, blue: 242 / 255))
                        })
                        
                    }
                    
                    
                }.navigationBarHidden(true)
                    .navigationBarTitle("")
            }
        }
    }
    
    struct WelcomeView_Previews: PreviewProvider {
        static var previews: some View {
            WelcomeView()
        }
    }
}
