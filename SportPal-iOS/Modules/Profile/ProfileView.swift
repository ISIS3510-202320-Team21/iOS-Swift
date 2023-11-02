//
//  ProfileViewModel.swift
//  SportPal-iOS
//
//  Created by Alejandro Tovar on 3/10/23.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var profileViewModel = ProfileViewModel(user: UserModel())
    @State private var isNavigatingBack: Bool = false
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    @State private var image: UIImage?
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderBack(title: "MY PROFILE") {
                    self.isNavigatingBack = true
                }
                //systemName: "person.crop.circle.fill.badge.plus"
                Image(uiImage: image ??  UIImage(named:"ProfileUser")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .foregroundColor(Color.black)
                    .offset(y:30)
                Button("Choose pic") {
                    self.showSheet = true
                }.padding()
                    .actionSheet(isPresented: $showSheet) {
                        ActionSheet(title: Text("Select Photos"), message: Text("Choose"), buttons: [
                            .default(Text("Photo Library")){
                                self.showImagePicker = true
                                self.sourceType = .photoLibrary
                                
                            },.default(Text("Camera")){
                                self.showImagePicker = true
                                self.sourceType = .camera
                            },.cancel()])
                    }
                
                Text("\(profileViewModel.user.name)").font(.title).fontWeight(.regular).offset(y:30)
                Spacer()
                Spacer()
                VStack (alignment:.leading){
                    
                    Button(action: {
                        // TODO: implement signup

                    }) {
                        HStack {
                            Image(systemName: "person.crop.circle.badge.exclamationmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.black)
                            Spacer()
                            Text("Edit my profile").font(.title).fontWeight(.thin).foregroundColor(Color.black)
                            Spacer()
                        }.frame(height: 60).padding()
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
                        }.frame(height: 60).padding()
                    }
                    Button(action: {
                        // TODO: implement signup

                    }) {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.black)
                            Spacer()
                            Text("Sign Out").font(.title).fontWeight(.thin).foregroundColor(Color.black)
                            Spacer()
                        }.frame(height: 60).padding()
                    }
                }
                Spacer()
                FooterView(viewModel: FooterViewModel(
                    homeButtonAction: NavigateToHomeActionStrategy(),
                    newMatchButtonAction: NavigateToNewMatchActionStrategy(),
                    profileButtonAction: NavigateToProfileActionStrategy()
                ))
            }.background(Color(red: 0.961, green: 0.961, blue: 0.961))
        }.navigationBarBackButtonHidden(true)
            .background(NavigationLink(
                destination: LandingView(),
                isActive: $isNavigatingBack,
                label: {EmptyView()}))
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $image, isShown: self.$showImagePicker, sourceType: self.sourceType)
            }
    }
}

struct ProfileViewModel_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
