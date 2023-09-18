//
//  CreateTweetViewModel.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 16/02/23.
//

import SwiftUI


class CreateTweetViewModel: ObservableObject {
    func uploadPost(text: String, image: UIImage?){
        guard let user = AuthViewModel.shared.currentUser else {
            return }
        print("create tweet view model called")
        print(image)
        RequestServices.postTweet(text: text, user: user.name!, username: user.username, userId: user.id) { result in
            print("got result of post tweet")
            if let image = image {
                if let id = result?["_id"] {
                    ImageUploader.uploadImage(paramName: "upload", fileName: "\(id)", image: image, urlPath: "/uploadTweetImage/\(id)")
                }
            }
            
        }
    }
}
