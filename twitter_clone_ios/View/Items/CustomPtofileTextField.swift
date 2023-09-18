//
//  CustomPtofileTextField.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 13/03/23.
//

import SwiftUI

struct CustomPtofileTextField: View {
    
    @Binding var message: String
    var placeholder: String
    
    var body: some View {
        HStack{
            ZStack{
                HStack{
                    if message.isEmpty{
                        Text(placeholder)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                
                TextField("", text: $message)
                    .foregroundColor(.blue)
            }
        }
    }
}


