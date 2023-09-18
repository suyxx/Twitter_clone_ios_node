//
//  MenuButton.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 18/01/23.
//

import SwiftUI

struct MenuButton: View {
    
    var title: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(title)
                .resizable()
                .renderingMode(.template)
                .frame(width: 24, height: 24)
                .foregroundColor(.gray)
            
            Text(title)
                .foregroundColor(.black)
            
            Spacer(minLength: 0)
            
        }
        .padding(.vertical, 12)
    }
}

