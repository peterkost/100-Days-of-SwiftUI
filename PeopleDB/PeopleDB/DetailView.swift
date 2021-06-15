//
//  DetailView.swift
//  PeopleDB
//
//  Created by Peter Kostin on 2021-06-15.
//

import SwiftUI
import MapKit

struct DetailView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    
    var image: UIImage
    var name: String
    var location: CodableMKPointAnnotation
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width )
                MapView(centerCoordinate: $centerCoordinate, annotation: location)
            }

        }
        .navigationBarTitle(name)

    }
}
