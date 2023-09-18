//
//  SearchCell.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 18/01/23.
//

import SwiftUI

struct SearchCell: View {
    
    var tag = ""
    var tweets = ""
    
    var body: some View {
        HStack{
            VStack(alignment: .leading,spacing: 5, content: {
                Text("Hello").fontWeight(.heavy)
                Text(tweets + " Tweets").fontWeight(.light)
            })
            .padding(0)
        }
    }
}

struct SearchCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchCell()
    }
}
