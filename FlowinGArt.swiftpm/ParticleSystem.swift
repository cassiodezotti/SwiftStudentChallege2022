//
//  ParticleSystem.swift
//  GenMachine
//
//  Created by Cassio Dezotti on 25/04/22.
//

import Foundation
import SwiftUI


class ParticleSystem {
    var particles = [Particle]()
    var center = UnitPoint.center
    var lastUpdate: Date = Date()
    var flowFieldType: FlowPattern = .Trigonometric
    var selectedBrush: BrushPattern = .circle
    var selectedColor: ColorPalette = .warm
    var step: Double = 0.005
    var resolution: Double = 0.1
    var iterations: Int = 0
    
    
    
    func selectBrush() -> some Shape{
        switch self.selectedBrush {
        case .circle:
            return AnyShape(Circle())
        case .fillcircle:
            return AnyShape(Circle())
        case .square:
            return AnyShape(Rectangle())
        case .fillsquare:
            return AnyShape(Rectangle())
        case .triangle:
            return AnyShape(Triangle())
        case .filltriangle:
            return AnyShape(Triangle())
       
            
        }
    }
    
    
    func update(newParticle: Particle) {
        particles.append(newParticle)
    }
    
    
    func applyFlowField(particle: Particle, size: CGSize){
        let time = lastUpdate.timeIntervalSince(particle.particleTime)
        
        
        
        var point = CGPoint(x: 0, y: 0)
        switch self.flowFieldType{
        case .Trigonometric:
            
            if self.selectedBrush == .triangle || self.selectedBrush == .filltriangle{
                self.step = 0.02
            }else {
                self.step = 0.005
            }
            
            point = CGPoint(x: particle.trail.last!.x + ( Double.random(in: (self.step/5)...(self.step))) * Double(particle.direction), y: (sin(time ) ) * Double(particle.direction) * particle.oscilating)
            break
        case .StraightLine:
            self.step = 0.005
            point = CGPoint(x: (particle.trail.last!.x + tan(self.step)) * Double(particle.direction), y: particle.trail.last!.y + (self.step) * Double(particle.direction))
            break
        case .Forms:
            self.step = 0.005
            point = CGPoint(x: particle.trail.last!.x + (self.step/5) * Double(particle.direction), y:
                                ((Double.random(in: 0...1) * particle.trail.last!.x) + Double.random(in: 1...2)) * Double(particle.direction) * particle.oscilating)
            break
        }
        
        //verify if pass the border
        if point.x < 1.5 && point.x > -0.5 && point.y < 1.5 && point.y > -0.5{
            particle.update(point: point)
            if(particle.trail[particle.trail.endIndex-1].x <= -1) {
                particle.trail[particle.trail.endIndex-1].x = 1
            }
            if(particle.trail[particle.trail.endIndex-1].y <= -1) {
                particle.trail[particle.trail.endIndex-1].y = 1
            }
        }
        
        
        if(time >= (2 * Double.pi)) {
            particle.particleTime = Date()
            
        }
        
    }
}
