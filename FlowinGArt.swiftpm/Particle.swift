//
//  Particle.swift
//  GenMachine
//
//  Created by Cassio Dezotti on 25/04/22.
//

import Foundation
import SwiftUI

class Particle {
    
    var radius: CGFloat
    var trail = [CGPoint]()
    var particleTime = Date.now
    var color: GraphicsContext.Shading
    var initialPoint: CGPoint
    var direction: Int = 1
    var oscilating: Double
    
    init(radius: CGFloat, point: CGPoint, color: GraphicsContext.Shading, direction: Int, oscilating: Double){
        self.direction = direction
        self.color = color
        self.initialPoint = point
        self.radius = radius
        self.trail.append(point)
        self.oscilating = oscilating
        
    }
    
    func update(point: CGPoint) {
        self.trail.append(point)
    }
}
