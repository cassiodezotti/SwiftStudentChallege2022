//
//  Util.swift
//  GenMachine
//
//  Created by Cassio Dezotti on 25/04/22.
//

import Foundation
import SwiftUI



public var warmColors: [GraphicsContext.Shading] =
[
    .color(Color("warm1")),
    .color(Color("warm2")),
    .color(Color("warm3")),
    .color(Color("warm4")),
]
public var coldColors: [GraphicsContext.Shading] =
[
    .color(Color("cold1")),
    .color(Color("cold2")),
    .color(Color("cold3")),
    .color(Color("cold4")),
]
public var brasilColors: [GraphicsContext.Shading] =
[
    .color(Color("brasil1")),
    .color(Color("brasil2")),
    .color(Color("brasil3")),
    .color(Color("brasil4")),
]
public var earthColors: [GraphicsContext.Shading] =
[
    .color(Color("earth1")),
    .color(Color("earth2")),
    .color(Color("earth3")),
    .color(Color("earth4")),
]
public var oceanColors: [GraphicsContext.Shading] =
[
    .color(Color("ocean1")),
    .color(Color("ocean2")),
    .color(Color("ocean3")),
    .color(Color("ocean4")),
]
public var rainbowColors: [GraphicsContext.Shading] =
[
    .color(Color("rainbow1")),
    .color(Color("rainbow2")),
    .color(Color("rainbow3")),
    .color(Color("rainbow4")),
    .color(Color("rainbow5")),
]
public var natureColors: [GraphicsContext.Shading] =
[
    .color(Color("nature1")),
    .color(Color("nature2")),
    .color(Color("nature3")),
    .color(Color("nature4")),
]

public enum BrushPattern: Int, CaseIterable{
    case circle = 0
    case fillcircle = 1
    case square = 2
    case fillsquare = 3
    case triangle = 4
    case filltriangle = 5
}
public enum FlowPattern: Int, CaseIterable{
    case Trigonometric = 0
    case StraightLine = 1
    case Forms = 2
}
public enum ColorPalette: Int, CaseIterable{
    case warm = 0
    case cold = 1
    case earth = 2
    case ocean = 3
    case nature = 4
    case brasil = 5
    case rainbow = 6
    
}

struct AnyShape: Shape {
    private let builder: (CGRect) -> Path
    
    init<S: Shape>(_ shape: S) {
        builder = { rect in
            let path = shape.path(in: rect)
            return path
        }
    }
    func path(in rect: CGRect) -> Path {
        return builder(rect)
    }
}
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}
