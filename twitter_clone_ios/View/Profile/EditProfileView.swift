//
//  EditProfileView.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 13/03/23.
//

import SwiftUI
import Kingfisher

struct EditProfileView: View {
    
    @State var profileImage: Image?
    @State private var selectImage: UIImage?
    @State var imagePickerPresented = false
    
    @ObservedObject var viewModel : EditProfileViewModel
    
    @Binding var user : User
    @State var name : String
    @State var location : String
    @State var bio : String
    @State var website : String
    @Environment(\.presentationMode) var mode
    
    init(user: Binding<User>){
        self._user = user
        self.viewModel = EditProfileViewModel(user: self._user.wrappedValue)
        self._name = State(initialValue: self._user.name.wrappedValue ?? "")
        self._location = State(initialValue: self._user.location.wrappedValue ?? "")
        self._bio = State(initialValue: self._user.bio.wrappedValue ?? "")
        self._website = State(initialValue: self._user.website.wrappedValue ?? "")
    }
    
    var body: some View {
        VStack{
            ZStack{
                HStack{
                    Button(action: {
                        self.mode.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(.black)
                    })
                    Spacer()
                    Button(action: {
                        print("save pressed")
                        if (selectImage != nil){
                            self.viewModel.uploadProfileImage(text: "text", image: selectImage!)
                            self.viewModel.uploadUserData(name: name, bio: bio, website: website, location: location)
                            KingfisherManager.shared.cache.clearCache()
                        }else{
                            self.viewModel.uploadUserData(name: name, bio: bio, website: website, location: location)
                        }
                        
                    }, label: {
                        Text("Save")
                            .foregroundColor(.black)
                    })
                }.padding()
                HStack{
                    Spacer()
                    Text("Edit Profile")
                        .fontWeight(.heavy)
                    Spacer()
                }
            }
            VStack{
                Image("banner")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: getRect().width,height: 180, alignment: .center)
                    .cornerRadius(0)
                
                HStack{
                    if profileImage == nil {
                        Button {
                            self.imagePickerPresented.toggle()
                        } label: {
                            KFImage(URL(string: "http://localhost:3000/users/\(self.viewModel.user.id)/avatar"))
                                .resizable()
                                .placeholder{
                                    Image("Profile")
                                        .resizable()
                                        .aspectRatio( contentMode: .fill)
                                        .frame(width: 75, height: 75)
                                        .clipShape(Circle())
                                }
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())
                                .padding(8)
                                .background(Color.white)
                                .clipShape(Circle())
                                .offset(y: -20)
                                .padding(.leading, 12)
                        }
                        .sheet(isPresented: $imagePickerPresented) {
                            loadImage()
                        } content: {
                            ImagePicker(image: $selectImage)
                        }

                    }
                    else if let image = profileImage {
                        VStack{
                            HStack(alignment: .top, content: {
                                image.resizable()
                                    .aspectRatio( contentMode: .fill)
                                    .frame(width: 75, height: 75)
                                    .clipShape(Circle())
                                    .padding(8)
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .offset(y: -20)
                            })
                            .padding()
                        }.padding(.leading, 12)
                    }
                    Spacer()
                }
                .onAppear{
                    KingfisherManager.shared.cache.clearCache()
                }
                .padding(.top, -25)
                .padding(.bottom, -10)
                
                VStack{
                    Divider()
                    HStack{
                        ZStack{
                            HStack{
                                Text("Name")
                                    .foregroundColor(.black)
                                    .fontWeight(.heavy)
                                Spacer()
                            }
                            CustomPtofileTextField(message: $name, placeholder: "Add your name")
                                .padding(.leading, 90)
                        }
                    }.padding(.horizontal)
                    Divider()
                    HStack{
                        ZStack{
                            HStack{
                                Text("Location")
                                    .foregroundColor(.black)
                                    .fontWeight(.heavy)
                                Spacer()
                            }
                            CustomPtofileTextField(message: $location, placeholder: "Add your location")
                                .padding(.leading, 90)
                        }
                    }.padding(.horizontal)
                    
                    Divider()
                    HStack{
                        ZStack(alignment: .topLeading){
                            HStack{
                                Text("Bio")
                                    .foregroundColor(.black)
                                    .fontWeight(.heavy)
                                Spacer()
                            }
                            CustomProfileBioTextField(bio: $bio)
                                .padding(.leading, 86)
                                .padding(.top, -6)
                        }
                    }.padding(.horizontal)
                    Divider()
                    HStack{
                        ZStack{
                            HStack{
                                Text("Website")
                                    .foregroundColor(.black)
                                    .fontWeight(.heavy)
                                Spacer()
                            }
                            CustomPtofileTextField(message: $website, placeholder: "Add your website")
                                .padding(.leading, 90)
                        }
                    }.padding(.horizontal)
                    
                }
                
            }
            Spacer()
            
        }
        .onReceive(viewModel.$uploadComplete) { complete in
            if complete {
                self.mode.wrappedValue.dismiss()
                self.user.name = viewModel.user.name
                self.user.website = viewModel.user.website
                self.user.location = viewModel.user.location
                self.user.bio = viewModel.user.bio
            }
        }
    }
}

extension EditProfileView {
    func loadImage(){
        guard let selectImage = selectImage else {return}
        profileImage = Image(uiImage: selectImage)
    }
}
