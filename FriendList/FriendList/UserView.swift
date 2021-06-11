//
//  UserView.swift
//  FriendList
//
//  Created by Peter Kostin on 2021-06-11.
//

import SwiftUI

struct UserView: View {
    let user: User
    let users: [User]
    let friends: [User]
    
    var body: some View {
        Form {
            Section(header: Text("About")) {
                Text(user.about)
                Text("\(user.age) years old.")
                Text("Works at \(user.company)")
                Text("Tags: \(user.tags.joined(separator: ", "))")
            }
            
            Section(header: Text("Contact")) {
                Text("Email: \(user.email)")
                Text("Address: \(user.address)")
            }
            
            Section(header: Text("Friends")) {
                ForEach(friends) { friend in
                    NavigationLink(destination: UserView(user: friend, users: users)) {
                        Text("\(friend.isActive ? "🟢" : "🔴") \(friend.name)")
                    }
                }
            }
            
        }
        .navigationBarTitle(user.name)
    }
    
    init(user: User, users: [User]) {
        self.user = user
        self.users = users
        
        var matches = [User]()

        for friend in user.friends {
            if let match = users.first(where: { $0.id == friend.id }) {
                matches.append(match)
            }
        }
        self.friends = matches
    }
}
