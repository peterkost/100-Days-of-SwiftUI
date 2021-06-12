//
//  ContentView.swift
//  FriendList
//
//  Created by Peter Kostin on 2021-06-09.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: CDUser.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \CDUser.name, ascending: true)
    ]) var cdUsers: FetchedResults<CDUser>
    
    var body: some View {
        NavigationView {
            Group {
                if cdUsers.isEmpty {
                    Button("Download Frind List") {
                        getFriendList()
                    }
                } else {
                    List {
                        ForEach(cdUsers, id: \.self) { user in
                             NavigationLink(destination: UserView(cdUser: user)) {
                            Text(user.uwName)
                             }
                        }
                    }
                }
            }
            .navigationBarTitle("Friend List")
        }
    }
    
    func getFriendList() {
        // Generate Request
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        let request = URLRequest(url: url)

        // Send Request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                // Process Responce
                if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
                    saveFriendListToCoreData(jsonUsers: decodedResponse)
                }
            }
        }.resume()
    }
    
    // idealy the JSON would be read directly into CoreData, but I spent too long trying to figure this out.
    // it should be not to hard, just need to make the CDUser class codable
    func saveFriendListToCoreData(jsonUsers: [User]) {
        var tempArray = [CDUser]()
        for jsonUser in jsonUsers {
            let newCDUser = CDUser(context: moc)
            newCDUser.about = jsonUser.about
            newCDUser.address = jsonUser.address
            newCDUser.age = Int16(jsonUser.age)
            newCDUser.company = jsonUser.company
            newCDUser.email = jsonUser.email
            newCDUser.id = jsonUser.id
            newCDUser.isActive = jsonUser.isActive
            newCDUser.name = jsonUser.name
            newCDUser.registered = jsonUser.registered
            newCDUser.tags = jsonUser.tags
            tempArray.append(newCDUser)
        }
    
        for i in 0..<jsonUsers.count {
            for friend in jsonUsers[i].friends {
                if let newFriend = tempArray.first(where: { $0.id == friend.id }) {
                    tempArray[i].addToFriend(newFriend)
                }
            }
        }
        
        do {
            try moc.save()
        }
        catch let error {
            print("Could not save data: \(error.localizedDescription)")
        }

        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
