//
//  MessagesView.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 16/01/23.
//

import SwiftUI

struct MessagesView: View {
    var body: some View {
        VStack{
            ScrollView{
                ForEach(0..<9){
                    _ in
                    MessageCell()
                }
            }
        }
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
