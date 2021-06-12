//
//  FriendListApp.swift
//  FriendList
//
//  Created by Peter Kostin on 2021-06-09.
//

import SwiftUI

@main
struct FriendListApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
