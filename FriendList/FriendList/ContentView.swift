//
//  ContentView.swift
//  FriendList
//
//  Created by Peter Kostin on 2021-06-09.
//

import SwiftUI

struct ContentView: View {
    @State var users = [User]()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users) { user in
                    NavigationLink(destination: UserView(user: user, users: users)) {
                        Text(user.name)
                    }
                    
                }
            }
            .navigationBarTitle("Friend List")
        }
        .onAppear(perform: loadData)
    }
    
    
    func loadData() {
        // Generate Request
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        let request = URLRequest(url: url)

        // Send Request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                // Process Responce
                if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
                    users = decodedResponse
                }
            }
        }.resume()

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
