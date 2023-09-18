//
//  MessageCell.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 18/01/23.
//

import SwiftUI

struct MessageCell: View {
    
    @State var width = UIScreen.main.bounds.width
    
    var body: some View {
        VStack(alignment: .leading,spacing: nil) {
            Rectangle()
                .frame(width: width, height: 1, alignment: .center)
                .foregroundColor(.gray)
                .opacity(0.3)
            
            HStack{
                Image("suyash")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .cornerRadius(30)
                    .padding(.leading)
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    HStack{
                        Text("Suyash ")
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Text("@suyash_saurabh")
                            .foregroundColor(.gray)
                        
                        Spacer(minLength: 0)
                        Text("6/22/21")
                            .padding(.trailing)
                    }
                    
                    Text("you have reached to your message")
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
            }.padding(.top, 4)
        }.frame(width: width, height: 84)
    }
}

struct MessageCell_Previews: PreviewProvider {
    static var previews: some View {
        MessageCell()
    }
}
