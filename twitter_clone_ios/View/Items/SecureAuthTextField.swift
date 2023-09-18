//
//  SecureAuthTextField.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 20/01/23.
//

import SwiftUI

struct SecureAuthTextField: View {
    
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading){
            ZStack(alignment: .leading){
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.gray)
                }
                    SecureField("", text: $text)
                        .frame(height: 45)
                        .foregroundColor(Color(red: 29 / 255, green: 161 / 255, blue: 242 / 255))
                        
                
            }
            Rectangle()
                .frame(height: 1, alignment: .center)
                .foregroundColor(.gray)
                .padding(.top, -2)
            
        }.padding(.horizontal)
    }
}


