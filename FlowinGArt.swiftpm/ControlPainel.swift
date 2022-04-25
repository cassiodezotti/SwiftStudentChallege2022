//
//  ControlPainel.swift
//  GenMachine
//
//  Created by Cassio Dezotti on 22/04/22.
//

import SwiftUI

struct ControlPainel: View {
    
    @Binding var sliderRange: ClosedRange<Float>
    @Binding var number: Double
    @State var isEditingNumber = false
    @Binding var pathSelected: Int
    @Binding var colorSelected: Int
    @Binding var brushSelected: Int
    @State var showPopover: Bool = false
    
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color("grayCard"))
            VStack{
                VStack {
                    HStack{
                        Text("Number of particles")
                            .foregroundColor(.black)
                            .font(.title)
                            .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                        Spacer()
                    }
                    HStack(){
                        Image("particle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color("icon"))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
                        Slider(
                            value: $number,
                            in: 0...100,
                            onEditingChanged: { editing in
                                isEditingNumber = editing
                            }
                        )
                        .foregroundColor(Color("AccentColor"))
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                        Image("particle.multi")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(Color("icon"))
                            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                    }
                }
                
                VStack {
                    HStack{
                        Text("Particle size")
                            .foregroundColor(.black)
                            .font(.title)
                            .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                        Spacer()
                    }
                    HStack{
                        Image(systemName: "star")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(Color("icon"))
                            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 20))
                        RangedSliderView(value: $sliderRange, bounds: 0...70)
                            .foregroundColor(Color("AccentColor"))
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                        Image(systemName: "star")
                            .resizable()
                            .frame(width: 38, height: 38)
                            .foregroundColor(Color("icon"))
                    }
                }
                
                ButtonsViews(pathSelected: self.$pathSelected,
                             colorSelected: self.$colorSelected,
                             brushSelected: self.$brushSelected
                )
            }
            .padding(EdgeInsets(top: 16, leading: 50, bottom: 16, trailing: 50))
        }
        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
        .padding(EdgeInsets(top: 0, leading: 32, bottom: 32, trailing: 32))
        
    }
}



struct ButtonsViews: View {
    
    @Binding var pathSelected: Int
    @Binding var colorSelected: Int
    @Binding var brushSelected: Int
    
    var body: some View {
        HStack{
            Spacer()
        }
        HStack(spacing: 20){
            MenuButtons(
                icon: "arrow.triangle.swap",
                popoverView:
                    AnyView(
                        VStack {
                            Text("Flow Field Path ↗️")
                                .font(.largeTitle)
                                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                            
                            Text("You may have heard of vector fields, or flow fields, which are often taught in basic physics. They are often used to model some force, such as magnetic or gravitational force, as their position changes from a point in space, and their value also changes. But such a concept can also be applied to Generative Art! As a great tool to create impressive works with particle systems. The image below illustrates a fictitious representation of a flow field, where we use the angle of each of the grid vectors to move the red particle, drawing a curved line. It is possible to create an infinity of possible paths with this concept, in this App three different flow fields were implemented, one based on sine and cosine trigonometric functions, another based on constant straight lines, and the last one using non-continuous vectors for a little chaos 😈. Have a great experience! 🎉")
                                .font(.headline)
                                .padding(EdgeInsets(top: 15, leading: 50, bottom: 20, trailing: 50))
                            Image("flowfield")
                                .resizable()
                                .frame(width: 250, height: 250, alignment: .center)
                            Spacer()
                            
                        }.frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height/1.3, alignment: .center)
                        
                    ),
                iconSize: 30,
                options: [
                    Text("Trigonometric"),
                    Text("Straight Lines"),
                    Text("Non Continuous"),
                ],
                selected: self.$pathSelected)
            MenuButtons(
                icon: "paintbrush",
                popoverView:
                    AnyView(
                        VStack {
                            Text("Brush Types  🖌")
                                .font(.largeTitle)
                                .padding(EdgeInsets(top: 20, leading: 0, bottom: 15, trailing: 0))
                            Text("A very common thing in the conventional arts is the use of different tools and techniques to achieve varied results 🤩. It is possible, for example, to produce many unique effects depending on the type of brush used, some image editing software is already capable of implementing an infinity type of brushes. In generative art it is no different, there is a constant effort to create new compositions from shapes and thus seek to reproduce real-life effects. This app makes use of basic geometric shapes such as triangles, squares, and circles to simulate brushes, you can also choose between filled or stroked shapes. Feel free to try, and have fun! 🥳")
                                .font(.headline)
                                .padding(EdgeInsets(top: 15, leading: 50, bottom: 0, trailing: 50))
                            Spacer()
                            
                        }.frame(width: UIScreen.main.bounds.size.width/1.8, height: UIScreen.main.bounds.size.height/1.5, alignment: .center)
                        
                    ),
                iconSize: 30, options: [
                    Text("Circles"),
                    Text("Filled Circles"),
                    Text("Squares"),
                    Text("Filled Squares"),
                    Text("Triangles"),
                    Text("Filled Triangles")
                ],
                selected: self.$brushSelected)
            MenuButtons(
                icon: "line.3.crossed.swirl.circle",
                popoverView:
                    AnyView(
                        VStack {
                            Text("Color Palette 🎨")
                                .font(.largeTitle)
                                .padding(EdgeInsets(top: 20, leading: 0, bottom: 15, trailing: 0))
                            Text("Who doesn't have a favorite color? Commonly people prefer one color to another, a set of colors is more pleasing to the eye, or this set is just part of the person's style 🧑‍🎨. Artists are not different, often throughout their career, they develop a personality, and a unique style and also express this through color palettes. With that in mind, the app has a large set of color palettes available to please everyone, feel free to explore them all! 🌈")
                                .font(.headline)
                                .padding(EdgeInsets(top: 15, leading: 50, bottom: 0, trailing: 50))
                            Spacer()
                            
                        }.frame(width: UIScreen.main.bounds.size.width/1.3, height: UIScreen.main.bounds.size.height/3, alignment: .center)
                        
                    ),
                iconSize: 30, options: [
                    
                    Text("Warm🔥"),
                    Text("Cold❄️"),
                    Text("Earth🌎"),
                    Text("Ocean🌊"),
                    Text("Nature🌿"),
                    Text("Brasil🇧🇷"),
                    Text("Raibow🌈")
                ],
                selected: self.$colorSelected)
        }
        .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
    }
    
}
