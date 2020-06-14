//
//  Ball.swift
//  Project11
//
//  Created by Carlos David on 09/04/2020.
//  Copyright © 2020 cdalvaro. All rights reserved.
//

import Foundation

class Ball {
    
    static let name = "ball"
    let color: Color
    
    init(color: Color? = nil) {
        self.color = color ?? .random()
    }
    
    func fileName() -> String {
        return "ball\(color)"
    }
}

extension Ball {
    enum Color: Int, CaseIterable {
        case blue
        case cyan
        case green
        case grey
        case purple
        case red
        case yellow
        
        static func random() -> Color {
            return Color.init(rawValue: Int.random(in: 0 ..< Color.allCases.count))!
        }
    }
}

extension Ball.Color: CustomStringConvertible {
    var description: String {
        switch self {
        case .blue:
            return "Blue"
        case .cyan:
            return "Cyan"
        case .green:
            return "Green"
        case .grey:
            return "Grey"
        case .purple:
            return "Purple"
        case .red:
            return "Red"
        case .yellow:
            return "Yellow"
        }
    }
}
