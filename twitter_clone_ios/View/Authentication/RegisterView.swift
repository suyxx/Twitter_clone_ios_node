//
//  RegisterView.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 20/01/23.
//

import SwiftUI

struct RegisterView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel

    @State var name = ""
    @State var email = ""
    @State var password = ""
    @Environment(\.presentationMode) var persentationMode
    
    var body: some View {
        VStack{
            ZStack{
                HStack{
                    Button(action: {
                        persentationMode.wrappedValue.dismiss()
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
            
            Text("Create your account")
                .font(.title)
                .bold()
                .padding(.top, 35)
            
            VStack(alignment: .leading, spacing: nil){
                
                CustomAuthTextField(placeholder: "Name", text: $name)
                CustomAuthTextField(placeholder: "Phone number or email", text: $email)
                CustomAuthTextField(placeholder: "Password", text: $password)
                
            }
            Spacer(minLength: 0)
            
            VStack{
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                
                HStack{
                    Spacer()
                    Button(action: {
                        self.viewModel.register(name: name, username: email, email: email, password: password)
                    }, label: {
                        Capsule()
                            .frame(width: 60, height: 30, alignment: .center)
                            .foregroundColor(Color("bg"))
                            .overlay(
                                Text("Next")
                                    .foregroundColor(.white)
                            )
                        
                            
                    })
                }.padding(.trailing, 24)
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
