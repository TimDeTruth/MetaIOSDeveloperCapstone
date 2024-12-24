//
//  Onboarding.swift
//  LittleLemon
//
//  Created by Timmy Lau on 2024-12-22.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"
let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var password: String = ""
    @State var email: String = ""
    
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationView {
            VStack {
                // NavigationLink to the Home screen
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }

                TextField("First Name", text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Last Name", text: $lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Register") {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && !password.isEmpty {
                        // Save user information to UserDefaults
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        // Navigate to the Home screen
                        isLoggedIn = true
 
                    } else {
                        print("Please fill in all fields.")
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding()
        }
        .onAppear(perform: {
            if UserDefaults.standard.bool(forKey: kIsLoggedIn){
                isLoggedIn = true
            }
        })
    }
}

#Preview {
    Onboarding(firstName: "", lastName: "", password: "", email: "")
}
