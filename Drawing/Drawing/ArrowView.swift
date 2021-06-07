//
//  Arrow.swift
//  Drawing
//
//  Created by Peter Kostin on 2021-06-07.
//

import SwiftUI

struct Arrow: Shape {
    var lineSize: CGFloat
    
    var animatableData: CGFloat {
        get { lineSize }
        set { self.lineSize = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let baseWidth: CGFloat = rect.maxX / lineSize
        let baseHeight: CGFloat = rect.maxY / lineSize
        let sideOfBase: CGFloat = (rect.maxX - baseWidth) / 2
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - baseHeight))
        path.addLine(to: CGPoint(x: sideOfBase, y: rect.maxY - baseHeight))
        path.addLine(to: CGPoint(x: sideOfBase, y: rect.maxY))
        path.addLine(to: CGPoint(x: baseWidth + sideOfBase, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX - sideOfBase, y: rect.maxY - baseHeight))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - baseHeight))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct ArrowView: View {
    @State private var lineSize: CGFloat = 2
    var body: some View {
        VStack {
            Arrow(lineSize: lineSize)
                .frame(width: 300, height: 300)
                .foregroundColor(.green)
            
            Spacer()
            
                Stepper(value: $lineSize.animation(), in: 2...10) {
                Text("Line Size")
            .padding()
            }
        }
    }
}

struct ArrowView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowView()
    }
}
