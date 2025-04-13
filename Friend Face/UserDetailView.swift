//
//  UserDetailView.swift
//  Friend Face
//
//  Created by Jeff Milner on 2025-04-11.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    @EnvironmentObject var usersData: UsersData
    
    var body: some View {
        List {
            Section("User Details") {
                Text(user.name)
                    .font(.headline)
                Text("Registered: \(user.registered)")
                Text("Age: \(user.age)")
                Text("Email: \(user.email)")
                Text("Address: \(user.address)")
                Text("Works for: \(user.company)")
            }
            Section("Friends") {
                ForEach(user.friends) { friend in
                    NavigationLink {
                        if let friendUser = usersData.users.first(where: { $0.id == friend.id }) {
                            UserDetailView(user: friendUser) // Recursive view
                        } else {
                            Text("Friend not found")
                        }
                    } label: {
                        Text(friend.name)
                    }
                }
            }
        }
        .navigationTitle(user.name)
    }
}


#Preview {
    let mockData = UsersData()
    let exampleUser = User(
        id: UUID(uuidString: "E621E1F8-C36C-495A-93FC-0C247A3E6E5F")!,
        isActive: true,
        name: "Jenny Doe",
        age: 29,
        company: "Acme Inc.",
        email: "jenny@example.com",
        address: "123 Main St",
        about: "Loves coding",
        registered: .now,
        tags: ["swift"],
        friends: [
            Friend(id: UUID(uuidString: "D621E1F8-C36C-495A-93FC-0C247A3E6E5A")!, name: "Jeff Milner"),
            Friend(id: UUID(uuidString: "F621E1F8-C36C-495A-93FC-0C247A3E6E5B")!, name: "Andrea Doe")
        ]
    )
    mockData.users = [exampleUser]
    
    return UserDetailView(user: exampleUser)
        .environmentObject(mockData)
}
