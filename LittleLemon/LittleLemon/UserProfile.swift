//
//  UserProfile.swift
//  LittleLemon
//
//  Created by Timmy Lau on 2024-12-23.
//

import SwiftUI


struct UserProfile: View {
    
    @Environment(\.presentationMode) var presentation
    
    let firstName = UserDefaults.standard.string(forKey: "first name key")
    let lastName = UserDefaults.standard.string(forKey: "last name key")
    let email = UserDefaults.standard.string(forKey: "email key")
    
    
//    @State private var temp1 = firstName
    //    @State private var temp2 = UserDefaults.standard.string(forKey: "last name key")
//    @State private var temp3 = UserDefaults.standard.string(forKey: "email key")
                                                            
    
    var body: some View {
        ScrollView{
            
            HStack(alignment: .center){
                Image("Logo")
//                Spacer()
                Image("Profile")
                    .resizable()
                    .frame(width: 50, height: 50,alignment: .leading)
                    
            }
            .padding()
            
            VStack{
                Text("Personal Information")
                    .bold()
                    .font(.title)
                
                HStack {
                    Image("Profile")
                        .resizable()
                        .frame(width: 80, height: 80, alignment: .leading)
                    
                    
                    
                    HStack(spacing:16) {
                        Button(action: {
                            
                        }, label: {
                            Text("Change")
                        })
                        .padding()
                        .background(Color.llGreen)
                        .foregroundStyle(Color.llMenuText)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                        Button(action: {
                            
                        }, label: {
                            Text("Remove")
                        })
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 15))

                    }
                    
              
                }
                .padding()
            }
           
            
            
        
            
            
            Group {
                Text("First Name")
                TextField("First Name",text: .constant(firstName ?? ""))
                    .padding()
                    .cornerRadius(8)
                
                
                Text("Last Name")
                TextField("Last Name",text: .constant(lastName ?? ""))
                    .padding()
                    .cornerRadius(8)
                
                Text("Email")
                TextField("Email",text: .constant(email ?? ""))
                    .padding()
                    .cornerRadius(8)
            }
       
    
            VStack(alignment: .leading, content: {
                Text("Email Notifications")
                
                Toggle("Order Statues", isOn: .constant(true))
                Toggle("Password Changes", isOn: .constant(false))
                Toggle("Special Offers", isOn: .constant(true))
                Toggle("Newsletter", isOn: .constant(false))
            })
            
            
 
                
                Button("Log out", action: {
                    UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                    
                    //automatically tell the NavigationView to go back to the previous screen which is Onboarding simulating logout.
                    self.presentation.wrappedValue.dismiss()
                    
                })
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .cornerRadius(8)
                .foregroundStyle(Color.black)
                .bold()
                .background(Color.llYellow)
                
            HStack{
                Button("Discard Changes"){
                    
                }
                .padding()
                .background(Color.llGreen)
                .foregroundStyle(Color.llMenuText)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                
                Spacer()
                Button("Save Changes"){
                    
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .padding()
            
            Spacer()
            
             

            
            
        }
        .padding()
    }
}


#Preview {
    UserProfile()
}
