//
//  EditProfileViewModel.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 14/03/23.
//

import SwiftUI

class EditProfileViewModel : ObservableObject {
    
    var user: User
    @Published var uploadComplete = false
    
    init(user: User) {
        self.user = user
    }
    
    func save(name: String?, bio: String?, website: String?, location: String?){
        guard let userNewName = name else {
            return
        }
        
        guard let userNewBio = bio else {
            return
        }
        
        guard let userNewWebsite = website else {
            return
        }
        
        guard let userNewLocation = location else {
            return
        }
        
        self.user.name = userNewName
        self.user.bio = userNewBio
        self.user.website = userNewWebsite
        self.user.location = userNewLocation
        
    }
    
    func uploadProfileImage(text: String, image: UIImage?){
        guard AuthViewModel.shared.$currentUser != nil else {return}
        let urlString = "/users/me/avatar"
        if let image = image {
            ImageUploader.uploadImage(paramName: "avatar", fileName: "image1", image: image, urlPath: urlString)
        }
    }
    
    func uploadUserData(name: String?, bio: String?, website: String?,location: String?)
    {
        let userId = user.id
        print("userid:  \(userId)")
        let urlPath = "users/\(userId)"
        AuthService.makePatchRequestWithAuth(urlString: urlPath, reqBody: ["name": name, "bio": bio, "website": website, "location": location]) {
            result in
            print(result)
            DispatchQueue.main.async {
                self.save(name: name, bio: bio, website: website, location: location)
                self.uploadComplete = true
            }
        }
    }
}
