//
//  Parallelogram.swift
//  Drawing
//
//  Created by Peter Kostin on 2021-06-07.
//

import SwiftUI

struct Trapezoid: Shape {
    var tilt: CGFloat = 40

    func path(in rect: CGRect) -> Path {
        var path = Path()

        //path.move(to: CGPoint(x: tilt, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - tilt, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: tilt, y: rect.maxY))

        return path
   }
}


struct Parallelogram: View {
    var body: some View {
        Trapezoid()
            .frame(width: 200, height: 100)
    }
}

struct Parallelogram_Previews: PreviewProvider {
    static var previews: some View {
        Parallelogram()
    }
}
