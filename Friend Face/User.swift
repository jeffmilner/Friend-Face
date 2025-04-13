//
//  User.swift
//  Friend Face
//
//  Created by Jeff Milner on 2025-04-11.
//

import Foundation

struct User: Codable, Identifiable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
    
    var formattedDate: String {
        registered.formatted(date: .abbreviated, time: .omitted)
    }
    
    static let example = User(
        id: UUID(),
        isActive: true,
        name: "Jenny Doe",
        age: 29,
        company: "Acme Inc.",
        email: "jenny@example.com",
        address: "123 Main St, Anytown, Canada",
        about: "I love coding and traveling.",
        registered: Date(),
        tags: ["coding", "traveling"],
        friends: [Friend(id: UUID(), name: "Jeff Milner"), Friend(id: UUID(), name: "Andrea Doe")]
        )
}

struct Friend: Codable, Identifiable {
    var id: UUID
    var name: String
}

class UsersData: ObservableObject {
    @Published var users = [User]()
}
