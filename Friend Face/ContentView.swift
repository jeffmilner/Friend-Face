//
//  ContentView.swift
//  FriendFace
//
//  Created by Jeff Milner on 2025-04-11.
//

import SwiftUI

struct ContentView: View {
    // Environment Object allows data to be shared with multiple views. Add the @EnvironmentObject var to each view that needs access. In this case the variable holds all the JSON data so that the user list can be accessed inside of UserDetailView.
    //
    // More on EnvironmentObject: https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-environmentobject-to-share-data-between-views
    
    @EnvironmentObject var usersData: UsersData
    
    var body: some View {
        NavigationView {
            
            //Loop through users in a list
            List(usersData.users) { user in
                NavigationLink {
                    //each user gets a link to UserDetailView with their details
                    UserDetailView(user: user)
                } label: {
                    HStack {
                        //Using nil coalescing show a green graphic if user is active and gray if not.
                        Image(systemName: "person.circle")
                            .foregroundColor(user.isActive ? .green : .gray)
                        
                    }
                    //In each iteration through the list show user's name
                    Text(user.name)
                }
            }
            //NavigationTitle must be after a view but inside the NavigationView's {}.
            .navigationTitle("Friend Face")
        }
        //This task will allow the views to continue while loading the data.
        // Details at: https://www.hackingwithswift.com/books/ios-swiftui/sending-and-receiving-codable-data-with-urlsession-and-swiftui

        .task {
            if let retrievedUsers = await getUsers() {
                usersData.users = retrievedUsers
            }
        }
    }
    
    // This function connects to the web to get the JSON data and puts it in an optional array of the type "User" (from struct in User.swift). There are three steps:
    func getUsers() async -> [User]? {
        // Step 1. set the url to the location of the JSON
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print ("Invalid URL")
            return nil
        }
        // Step 2. Fetch the data from the URL using Swift's built in URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            // this will return a tuple with JSON data as well meta data that is discarded because of the underscore (we don't need it) .
            let (data, _) = try await URLSession.shared.data(for: request)
            
            // Step 3. Decode the data into decodedData struct
            if let decodedData = try? decoder.decode([User].self, from: data) {
                return decodedData
            }
        } catch {
            // if the data value above is not able to be set for any reason print the error
            print("Invalid data")
        }
        return nil
    }
}

//#Preview {
//    ContentView()
//}
