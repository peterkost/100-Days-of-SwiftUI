//
//  SkiDetailsView.swift
//  SnowSeeker
//
//  Created by Peter Kostin on 2021-06-16.
//

import SwiftUI

struct SkiDetailsView: View {
    let resort: Resort

    var body: some View {
        Group {
            Text("Elevation: \(resort.elevation)m")
            Spacer().frame(height: 0)
            Text("Snow: \(resort.snowDepth)cm")
        }
    }
}

struct SkiDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SkiDetailsView(resort: Resort.example)
    }
}
