//
//  Home.swift
//  LittleLemon
//
//  Created by Timmy Lau on 2024-12-22.
//

import SwiftUI

struct Home: View {
    
    let persistance = PersistenceController.shared
    var body: some View {
        
        
        TabView{
            
            Menu()
                .environment(\.managedObjectContext, persistance.container.viewContext)//The Home screen will initialize the Core Data and pass its view context to the Menu instance on initialization.
            

                .tabItem({
                    Label("Menu", systemImage: "list.dash")
                })
            
            UserProfile()
                .tabItem({
                    Label("Profile", systemImage: "square.and.pencil")
                })
        }
        .navigationBarBackButtonHidden(true)
        .padding()
    }
}

#Preview {
    Home()
}
