//
//  Friend_FaceApp.swift
//  Friend Face
//
//  Created by Jeff Milner on 2025-04-11.
//

import SwiftUI

@main
struct Friend_FaceApp: App {
    @StateObject private var usersData = UsersData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(usersData)
        }
    }
}
