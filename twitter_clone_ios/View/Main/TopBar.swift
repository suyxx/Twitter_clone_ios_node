//
//  TopBar.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 18/01/23.
//

import SwiftUI

struct TopBar: View {
    
    @Binding var x: CGFloat
    
    @State var width = UIScreen.main.bounds.width
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    withAnimation{
                        x=0
                    }
                }, label: {
                    Image(systemName: "line.horizontal.3")
                        .font(.system(size: 24))
                        .foregroundColor(Color("bg"))
                })
                
                Spacer()
                
                Image("twitter_logo_blue")
                    .resizable()
                    .scaledToFill()
                    .padding(.trailing)
                    .frame(width: 30, height: 30)
                Spacer(minLength: 0)
            }
            .padding()
            Rectangle()
                .frame(width: width, height: 1)
                .foregroundColor(.gray)
                .opacity(0.3)
                
        }
    }
}


