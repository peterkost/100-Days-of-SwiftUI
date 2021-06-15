//
//  DetailView.swift
//  PeopleDB
//
//  Created by Peter Kostin on 2021-06-15.
//

import SwiftUI

struct DetailView: View {
    var image: UIImage
    var name: String
    var body: some View {
        GeometryReader { geo in
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width )
        }
        .navigationBarTitle(name)

    }
}
