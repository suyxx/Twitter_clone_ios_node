//
//  LoginView.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 20/01/23.
//

import SwiftUI

struct LoginView: View {
    
    @State var email = ""
    @State var password = ""
    @State var emailDone = false
    
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        if !emailDone {
            VStack{
                VStack{
                    ZStack{
                        
                        HStack{
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Text("Cancel")
                                    .foregroundColor(.blue)
                            })
                            
                            Spacer()
                        }.padding(.horizontal)
                        
                        Image("twitter_logo_blue")
                            .resizable()
                            .scaledToFill()
                            .padding(.trailing)
                            .frame(width: 40, height: 40)
                    }
                    
                    Text("To get started first enter your phone, email 0r @username")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    CustomAuthTextField(placeholder: "Phone, email or usename", text: $email)
                    
                }
                
                Spacer(minLength: 0)
                
                VStack{
                    Button(action: {
                        if !email.isEmpty{
                            self.emailDone.toggle()
                        }
                        
                    }, label: {
                        Capsule()
                            .frame(width: 360, height: 40)
                            .foregroundColor(Color("bg"))
                            .overlay(Text("Next").foregroundColor(.white))
                    }).padding(.bottom, 4)
                    
                    Text("Forgot password?")
                        .foregroundColor(.blue)
                }
                
            }
        }else{
            VStack{
                VStack{
                    ZStack{
                        
                        HStack{
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Text("Cancel")
                                    .foregroundColor(.blue)
                            })
                            
                            Spacer()
                        }.padding(.horizontal)
                        
                        Image("twitter_logo_blue")
                            .resizable()
                            .scaledToFill()
                            .padding(.trailing)
                            .frame(width: 40, height: 40)
                    }
                    
                    Text("Enter your password")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    SecureAuthTextField(placeholder: "Password", text: $password)
                    
                }
                
                Spacer(minLength: 0)
                
                VStack{
                    Button(action: {
                        self.emailDone.toggle()
                        self.viewModel.login(email: email, password: password)
                    }, label: {
                        Capsule()
                            .frame(width: 360, height: 40)
                            .foregroundColor(Color("bg"))
                            .overlay(Text("Login").foregroundColor(.white))
                    }).padding(.bottom, 4)
                    
                    Text("Forgot password?")
                        .foregroundColor(.blue)
                }
                
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
