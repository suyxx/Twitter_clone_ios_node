//
//  NotificationsView.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 16/01/23.
//

import SwiftUI

struct NotificationsView: View {
    var body: some View {
        VStack {
            ScrollView{
                ForEach(0..<9){ _ in
                    NotificationCell()
                }
            }
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
