//
//  UserView.swift
//  FriendList
//
//  Created by Peter Kostin on 2021-06-11.
//

import SwiftUI

struct UserView: View {
    let cdUser: CDUser
    
    var body: some View {
        Form {
            Section(header: Text("About")) {
                Text(cdUser.uwAbout)
                Text("\(cdUser.uwAge) years old.")
                Text("Works at \(cdUser.uwCompany)")
                Text("Tags: \(cdUser.uwTags.joined(separator: ", "))")
            }
            
            Section(header: Text("Contact")) {
                Text("Email: \(cdUser.uwEmail)")
                Text("Address: \(cdUser.uwAddress)")
            }
            
            Section(header: Text("Friends")) {
                ForEach(cdUser.friendArray) { friend in
                    NavigationLink(destination: UserView(cdUser: friend)) {
                        Text("\(friend.isActive ? "🟢" : "🔴") \(friend.uwName)")
                    }
                }
            }
            
        }
        .navigationBarTitle(cdUser.uwName)
    }
}
