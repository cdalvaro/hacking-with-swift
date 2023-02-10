//
//  ContentView.swift
//  Drawing
//
//  Created by Carlos Álvaro on 16/1/23.
//

import SwiftUI

struct Arrow: Shape {
    var strokeWidthWeight: Double {
        didSet {
            strokeWidthWeight = max(min(strokeWidthWeight, 1.0), 0.0)
        }
    }

    var strokeHeightWeight: Double {
        didSet {
            strokeHeightWeight = max(min(strokeHeightWeight, 1.0), 0.0)
        }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let arrowWeight = 1.0 - strokeHeightWeight
        let strokeWidth = rect.width * strokeWidthWeight

        path.move(to: CGPoint(x: rect.minX, y: rect.minY + rect.height * (strokeHeightWeight + arrowWeight / 2.0)))
        path.addLine(to: CGPoint(x: rect.minX + strokeWidth, y: rect.minY + rect.height * (strokeHeightWeight + arrowWeight / 2.0)))
        path.addLine(to: CGPoint(x: rect.minX + strokeWidth, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX + strokeWidth, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX + strokeWidth, y: rect.minY + rect.height * arrowWeight / 2.0))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + rect.height * arrowWeight / 2.0))

        return path
    }
}

struct ContentView: View {
    @State private var strokeWidthWeight = 0.7
    @State private var strokeHeightWeight = 0.4

    var body: some View {
        Arrow(strokeWidthWeight: strokeWidthWeight, strokeHeightWeight: strokeHeightWeight)
            .frame(width: 200, height: 100)
            .foregroundColor(.yellow)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
