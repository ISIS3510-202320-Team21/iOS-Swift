//
//  EditProfileView.swift
//  SportPal
//
//  Created by Javier Ramírez Silva on 4/11/23.
//

import SwiftUI

struct EditProfileView: View {
    
    @ObservedObject private var profileViewModel = ProfileViewModel()
    
    @Binding var navPaths: [Routes]
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var selectedRole: String = ""
    @State private var selectedUniversity: String = ""
    @State private var bornDate: Date = Date()
    @State private var selectedGender: String = ""
    
    
    var body: some View {
        ScrollView {
            LazyVStack () {
                HeaderBack(title: "EDIT PROFILE") {
                    navPaths.removeLast()
                }
                VStack{
                    VStack{
                        Group{
                            CustomTextField(
                                placeholder: "First Name...",
                                text: $name,
                                isValid: profileViewModel.isValidName(name: name)
                            ).padding(.horizontal)
                            
                            CustomTextField(
                                placeholder: "Email...",
                                text: $email,
                                isValid: profileViewModel.isValidEmail(email: email)
                            ).padding(.horizontal)
                            
                            CustomTextField(
                                placeholder: "Phone Number...",
                                text:$phoneNumber,
                                isValid: profileViewModel.isValidPhoneNumber(phoneNumber: phoneNumber)
                            ).padding(.horizontal).keyboardType(.phonePad)

                        }
                        
                        Group {
                            
                            DatePicker("Birth Date", selection: $bornDate, displayedComponents: .date)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 10).stroke(profileViewModel.isValidBornDate(bornDate: bornDate) ? Color(red: 0.175, green: 0.411, blue: 0.457, opacity: 100.0) : Color.red, lineWidth: 1))
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                            
                            if !profileViewModel.isValidBornDate(bornDate: bornDate) {
                                Text("You must be at least 18 to register").foregroundColor(Color.gray).padding(.bottom, 20)
                            }
                            Picker("Gender", selection: $selectedGender) {
                                Text("Select Gender").tag("")
                                ForEach(profileViewModel.genders, id: \.self) { gender in
                                    Text(gender).tag(gender)
                                }
                            }.pickerStyle(MenuPickerStyle())
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 10).stroke(profileViewModel.isValidGender(gender: selectedGender) ? Color(red: 0.175, green: 0.411, blue: 0.457, opacity: 100.0) : Color.red, lineWidth: 1))
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                            
                            Picker("University", selection: $selectedUniversity) {
                                Text("Select University").tag("")
                                ForEach(profileViewModel.universities, id: \.self) { university in
                                    Text(university).tag(university)
                                }
                            }.pickerStyle(MenuPickerStyle())
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 10).stroke(profileViewModel.isValidUniversity(university: selectedUniversity) ? Color(red: 0.175, green: 0.411, blue: 0.457, opacity: 100.0) : Color.red, lineWidth: 1))
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                            
                            Picker("Role", selection: $selectedRole) {
                                Text("Select Role").tag("")
                                ForEach(profileViewModel.roles, id: \.self) { role in
                                    Text(role).tag(role)
                                }
                            }.pickerStyle(MenuPickerStyle())
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 10).stroke(profileViewModel.isValidRole(role: selectedRole) ? Color(red: 0.175, green: 0.411, blue: 0.457, opacity: 100.0) : Color.red, lineWidth: 1))
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                        }
                        
                        Button(action: {
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "dd/MM/yyyy"
                            let formattedBornDate = dateFormatter.string(from: bornDate)
                            
                            let editData =  ProfileEditRequest(
                                email: email,
                                name: name,
                                phoneNumber: phoneNumber,
                                role: selectedRole,
                                university: selectedUniversity,
                                bornDate: formattedBornDate,
                                gender: selectedGender
                            )
                            
                            profileViewModel.editProfile(editData: editData) { result in
                                switch result {
                                case true:
                                    navPaths.append(.login)
                                case false: break
                                }
                            }
                        }) {
                            Text("Confirm")
                                .font(.title)
                                .padding(.horizontal, 80)
                                .padding(.vertical, 10)
                        }
                        .buttonStyle(CustomButtonStyle(isEnabled: profileViewModel.isConfirmButtonEnabled(name: name, email: email, phoneNumber: phoneNumber, role: selectedRole, university: selectedUniversity, bornDate: bornDate, gender: selectedGender)))
                        .padding(.horizontal)
                        .padding(.vertical, 20)
                        .disabled(!profileViewModel.isConfirmButtonEnabled(name: name, email: email, phoneNumber: phoneNumber, role: selectedRole, university: selectedUniversity, bornDate: bornDate, gender: selectedGender))
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 50.0)
                    
                }.background(Color(red: 0.961, green: 0.961, blue: 0.961))
                
            }
            .navigationBarBackButtonHidden(true)
            .alert(isPresented: $profileViewModel.showAlert) {
                Alert(title: Text(profileViewModel.alertTitle), message: Text(profileViewModel.errorMessage), dismissButton: .default(Text("OK")))
            }
            .onAppear {
                name = profileViewModel.getUser().name
                email = profileViewModel.getUser().email
                phoneNumber = profileViewModel.getUser().phoneNumber
                bornDate = convertStringToDate(dateString: profileViewModel.getUser().bornDate)!
                selectedGender = profileViewModel.getUser().gender
                selectedUniversity = profileViewModel.getUser().university
                selectedRole = profileViewModel.getUser().role
            }
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(navPaths: .constant([]))
    }
}
