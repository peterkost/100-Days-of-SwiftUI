//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Peter Kostin on 2021-06-04.
//

import SwiftUI

struct BlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func blueTitleStyle() -> some View {
        modifier(BlueTitle())
    }
}

struct ContentView: View {
    @State private var xd = false
    var body: some View {
        Text("xd")
            .blueTitleStyle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
