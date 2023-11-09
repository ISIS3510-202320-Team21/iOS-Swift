//
//  ProfileViewModel.swift
//  SportPal-iOS
//
//  Created by Alejandro Tovar on 3/10/23.
//

import SwiftUI

struct ProfileView: View {
    
    @Binding var navPaths: [Routes]
    
    @State var changeProfileImage = false
    @State var openCameraRoll = false
    @State private var showSheet: Bool = false
//    @State var imageSelected = UIImage()
    @State var imageSelected: UIImage = {
            if let imageData = UserDefaults.standard.data(forKey: "selectedImage"),
               let uiImage = UIImage(data: imageData) {
                return uiImage
            } else {
                return UIImage() // Default image if none stored in UserDefaults
            }
        }()
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    @ObservedObject var profileViewModel = ProfileViewModel()
    //    @State private var showSheet: Bool = false
    //    @State private var showImagePicker: Bool = false
    //    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    @State private var image: UIImage?
    
    var imagePicker = UIImagePickerController()
    
    var body: some View {
        VStack {
            HeaderBack(title: "MY PROFILE") {
                navPaths.removeLast()
            }
            VStack {
                VStack {
                    Spacer()
                    Button(action: {
                        self.showSheet = true
//                        openCameraRoll = true
//                        profileViewModel.didTapChangeProfilePic()
                    }, label: {
                        if changeProfileImage {
                            Image(uiImage: imageSelected)
                                .profileImageMod()
                        } else if(GlobalParameters.shared.getUserSavedAnImage()){
                            Image(uiImage: imageSelected)
                                .profileImageMod()
                        } else {
                            Image(systemName: "person.crop.circle.fill.badge.plus")
                            
//                                .profileImageMod()
//                            Image(systemName: "person.crop.circle.fill.badge.plus")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200)
                                .foregroundColor(Color(red: 0.175, green: 0.411, blue: 0.457, opacity: 1.0))
                                .padding(.top, 50)
                        }
                    }).actionSheet(isPresented: $showSheet) {
                        ActionSheet(title: Text("Select Photos"), message: Text("Choose"), buttons: [
                            .default(Text("Photo Library")){
                                self.sourceType = .photoLibrary
                                self.openCameraRoll = true
                                changeProfileImage = true
                            },.default(Text("Camera")){
                                self.sourceType = .camera
                                self.openCameraRoll = true
                                changeProfileImage = true
                            },.cancel()])
                    }
                    
                    Text("\(profileViewModel.getUser().name)").font(.largeTitle).fontWeight(.light).offset(y:30)
                    Spacer()
                }.padding(.horizontal, 100)
                    .background(Color.white)
                    .cornerRadius(16)
                
                Spacer()
                VStack (alignment:.leading){
                    Button(action: {
                        navPaths.append(.editprofile)
                    }) {
                        HStack {
                            Image(systemName: "person.crop.circle.badge.exclamationmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.black)
                            Spacer()
                            Text("Edit my profile").font(.title).fontWeight(.thin).foregroundColor(Color.black)
                            Spacer()
                        }.padding()
                            .background(Color.white)
                            .cornerRadius(16).frame(height: 80)
                    }
                    Button(action: {
                        // TODO: implement signup
                        
                    }) {
                        HStack {
                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.black)
                            Spacer()
                            Text("Settings").font(.title).fontWeight(.thin).foregroundColor(Color.black)
                            Spacer()
                        }.padding()
                            .background(Color.white)
                            .cornerRadius(16).frame(height: 80)
                    }
                    Button(action: {
                        navPaths.append(.login)
                    }) {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.black)
                            Spacer()
                            Text("Sign Out").font(.title).fontWeight(.thin).foregroundColor(Color.black)
                            Spacer()
                        }.padding()
                            .background(Color.white)
                            .cornerRadius(16).frame(height: 80)
                    }
                }
                .padding(.vertical)
                Spacer()
            }.padding()
            FooterView(navPaths: $navPaths)
        }.navigationBarBackButtonHidden(true)
            .background(Color(red: 0.961, green: 0.961, blue: 0.961))
            .sheet(isPresented: $openCameraRoll) {
            ImagePicker(selectedImage: $imageSelected, sourceType: self.sourceType)
        }
            .onDisappear {
                if let imageData = imageSelected.jpegData(compressionQuality: 1.0) {
                    UserDefaults.standard.set(imageData, forKey: "selectedImage")
                    GlobalParameters.shared.setUserSavedAnImage(saved: true)
                }
            }
        
        //            .sheet(isPresented: $showImagePicker) {
        //                ImagePicker(image: $image, isShown: self.$showImagePicker, sourceType: self.sourceType)
        //            }
    }
}


struct ProfileViewModel_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(navPaths: .constant([]))
    }
}
