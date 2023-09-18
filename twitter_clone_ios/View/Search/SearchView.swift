//
//  SearchView.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 16/01/23.
//

import SwiftUI

struct SearchView: View {
    
    @State var text = ""
    @State var isEditing = false
    
    @ObservedObject var viewModel = SearchViewModel()
    
    var users: [User]{
        return text.isEmpty ? viewModel.users : viewModel.filterUsers(text)
    }
    
    var body: some View {
        VStack{
            SearchBar(text: $text, isEditing: $isEditing)
                .padding(.horizontal)
            
            LazyVStack {
                ForEach(users){ user in
                    NavigationLink(destination: UserProfile(user: user)) {
                        SearchUserCell(user: user)
                            .padding(.leading)
                    }
                }
            }
            Spacer()
        }
        }
    }


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
