//
//  ArtView.swift
//  GenMachine
//

//  Created by Cassio Dezotti on 20/04/22.
//

import SwiftUI
import UIKit



struct ArtView: View {
    
    @Binding var refresh: Bool
    @Binding var random: Bool
    @Binding var numberOfParticles: Double
    @Binding var size: ClosedRange<Float>
    @Binding var paused: Bool
    
    @Binding var pathPatternSelected: Int
    @Binding var colorPatternSelected: Int
    @Binding var brushPatternSelected: Int
    
    @State var particleSystem = ParticleSystem()
    @State var particles: [Particle] = []
    
    
    var colors: [[GraphicsContext.Shading]]
    
    init(numberOfParticles: Binding<Double>, refresh: Binding<Bool>,random: Binding<Bool>, size: Binding<ClosedRange<Float>>, paused: Binding<Bool>,pathPatternSelected: Binding<Int>, colorPatternSelected: Binding<Int>, brushPatternSelected: Binding<Int>  ) {
        
        self._pathPatternSelected = pathPatternSelected
        self._colorPatternSelected = colorPatternSelected
        self._brushPatternSelected = brushPatternSelected
        
        self._paused = paused
        self._size = size
        self._numberOfParticles = numberOfParticles
        self._random = random
        self._refresh = refresh
        
        self.colors = [warmColors,coldColors,earthColors,oceanColors, natureColors, brasilColors, rainbowColors]
        
        
        self.particleSystem.update(
            newParticle: Particle(
                radius: Double.random(in: Double(size.wrappedValue.lowerBound)...Double(size.wrappedValue.upperBound)),
                point: CGPoint(x: Double.random(in: 0...1), y: Double.random(in: 0...1)),
                color: colors[colorPatternSelected.wrappedValue].randomElement()!,
                direction: Int.random(in: -1...1),
                oscilating: Double.random(in: 0.1...1)
            )
        )
        //        }
    }
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 0.0001, paused: paused) ) { timeline in
            
            Canvas { context, size in
                
                particleSystem.lastUpdate = timeline.date
                for particle in particleSystem.particles{
                    
                    
                    particleSystem.applyFlowField(particle: particle, size: size)
                    
                    for trailPoint in particle.trail {
                        
                        
                        
                        if particleSystem.selectedBrush == .filltriangle || particleSystem.selectedBrush == .fillsquare || particleSystem.selectedBrush == .fillcircle{
                            context.fill(particleSystem.selectBrush().path(
                                in: CGRect(x: trailPoint.x * size.width, y: (trailPoint.y + particle.initialPoint.y) * particle.oscilating * size.height , width: particle.radius * 2, height: particle.radius * 2)), with: particle.color )
                            
                            
                        }else{
                            context.stroke(particleSystem.selectBrush().path(
                                in: CGRect(x: trailPoint.x * size.width, y: (trailPoint.y + particle.initialPoint.y) * particle.oscilating * size.height , width: particle.radius * 2, height: particle.radius * 2)), with: particle.color)
                        }
                        
                        
                        
                    }
                    
                }
                
                
                
            }
            
        }
        .background(Color("canvas"))
        .cornerRadius(20)
        .padding(EdgeInsets(top: 32, leading: 32, bottom: 32, trailing: 32))
        .onAppear(){
            refreshAll()
        }
        .onChange(of: numberOfParticles) { newValue in
            refreshAll()
        }
        .onChange(of: refresh){ newValue in
            refreshAll()
        }
        .onChange(of: size){ newValue in
            refreshAll()
        }
        .onChange(of: random){ newValue in
            
            
            self.particleSystem.selectedBrush = [.circle,.fillcircle,.square,.fillsquare,.triangle,.filltriangle].randomElement()!
            self.particleSystem.flowFieldType = [.Forms,.Trigonometric,.StraightLine].randomElement()!
            self.particleSystem.selectedColor = [.warm,.cold,.nature,.ocean,.earth,.brasil,.rainbow].randomElement()!
            
            self.colorPatternSelected =  self.particleSystem.selectedColor.rawValue
            self.pathPatternSelected =  self.particleSystem.flowFieldType.rawValue
            self.brushPatternSelected = self.particleSystem.selectedBrush.rawValue
            
            self.numberOfParticles = Double.random(in: 0...100)
            let lower = Float.random(in: 0...69)
            self.size = (lower)...(Float.random(in: lower...70))
            refreshAll()
        }
        .onChange(of: pathPatternSelected){ newValue in
            if let raw = FlowPattern(rawValue: newValue) {
                self.particleSystem.flowFieldType = raw
                refreshAll()
            }
            
        }
        .onChange(of: colorPatternSelected){ newValue in
            if let raw = ColorPalette(rawValue: newValue) {
                self.particleSystem.selectedColor = raw
                refreshAll()
            }
        }
        .onChange(of: brushPatternSelected){ newValue in
            if let raw = BrushPattern(rawValue: newValue) {
                self.particleSystem.selectedBrush = raw
                refreshAll()
            }
        }
        
    }
    
    func refreshAll() {
        particles.removeAll()
        particleSystem.particles.removeAll()
        
        for _ in 0...Int($numberOfParticles.wrappedValue){
            
            var point = CGPoint(x: Double.random(in: 0.1...0.9), y: Double.random(in: 0.1...0.9))
            var direction = Int.random(in: -1...1)
            
            if self.particleSystem.flowFieldType == .Trigonometric {
                point = CGPoint(x: Double(Int.random(in: 0...1)), y: Double.random(in: 0...1))
                direction = point.x == 0 ? 1 : -1
            }
            
            self.particleSystem.update(newParticle: Particle(radius: Double.random(in: Double(size.lowerBound)...Double(size.upperBound)), point: point, color: colors[$colorPatternSelected.wrappedValue].randomElement()!, direction: direction, oscilating: Double.random(in: 0.1...1) ))
        }
    }
    
}




