//
//  LittleLemonApp.swift
//  LittleLemon
//
//  Created by Timmy Lau on 2024-12-22.
//

import SwiftUI

@main
struct LittleLemonApp: App {
    var body: some Scene {
        WindowGroup {
            Onboarding(firstName: "john", lastName: "Deo", password: "123", email: "1@2.com")
        }
    }
}
