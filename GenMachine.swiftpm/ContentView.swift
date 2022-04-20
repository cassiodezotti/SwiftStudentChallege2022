import SwiftUI

struct ContentView: View {
    @State private var text = ""
    @State private var showPopover: Bool = false
    @State var showInfoModalView: Bool = true
    
    
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .cornerRadius(20)
                
                    .padding(EdgeInsets(top: 32, leading: 32, bottom: 32, trailing: 32))
                
                Button("LongPress to show popover") {
                    
                }.popover(
                    isPresented: self.$showPopover,
                    content: {
                        Text("Test")
                            .padding()
                    }
                ).simultaneousGesture(
                    LongPressGesture(minimumDuration: 0.5)
                        .onEnded( { _ in
                            self.showPopover = true
                            print("clicou long")
                        })
                )
                .highPriorityGesture(TapGesture()
                    .onEnded { _ in
                        print("clicou tap")
                    })
                
                
                .navigationBarItems(
                    trailing:
                        HStack {
                            NavButtons(icon: "pause", action: {print("clicou pause")}, longPressView: AnyView(Text("pause")))
                            NavButtons(icon: "arrow.clockwise", action: {print("clicou refresh")}, longPressView: AnyView(Text("refresh")))
                            NavButtons(icon: "shuffle", action: {print("clicou shuffe")}, longPressView: AnyView(Text("shuffle")))
                            NavButtons(icon: "info.circle", action: {print("clicou info")}, longPressView: AnyView(Text("info")))
                        }
                )
                Spacer()
                ControlPainel()
                    .padding(EdgeInsets(top: 84, leading: 0, bottom: 0, trailing: 0))
            }
        }.navigationViewStyle(StackNavigationViewStyle())
            .sheet(isPresented: self.$showInfoModalView) {
                OnBoardingView(isPresented: self.$showInfoModalView)
            }
        
        
    }
}

struct ButtonsViews: View {
    var body: some View {
        HStack{
            Spacer()
        }
        HStack(spacing: 13){
            Image(systemName: "arrow.triangle.swap" )
                .renderingMode(.template)
                .foregroundColor( Color(red: 28/255, green: 28/255, blue: 20/255))
                .font(.system(size: 26))
            Image(systemName: "paintbrush" )
                .renderingMode(.template)
                .foregroundColor( Color(red: 28/255, green: 28/255, blue: 20/255))
                .font(.system(size: 26))
            Image(systemName: "line.3.crossed.swirl.circle" )
                .renderingMode(.template)
                .foregroundColor( Color(red: 28/255, green: 28/255, blue: 20/255))
                .font(.system(size: 26))
            
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
    }
    
}




struct ControlPainel: View {
    
    @State private var number = 50.0
    @State private var size = 50.0
    @State private var isEditingNumber = false
    
    @State private var isEditingSize = false
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(red: 237/255, green: 237/255, blue: 239/255))
            VStack{
                VStack {
                    HStack{
                        Text("Number of particles")
                            .foregroundColor(.black)
                            .font(.title2)
                            .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                        Spacer()
                    }
                    HStack{
                        Image(systemName: "sparkle")
                        Slider(
                            value: $number,
                            in: 0...100,
                            onEditingChanged: { editing in
                                isEditingNumber = editing
                            }
                        )
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                        Image(systemName: "sparkles")
                    }
                }
                VStack {
                    HStack{
                        Text("Size range")
                            .foregroundColor(.black)
                            .font(.title2)
                            .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                        Spacer()
                    }
                    HStack{
                        Image(systemName: "star")
                        Slider(
                            value: $size,
                            in: 0...100,
                            onEditingChanged: { editing in
                                isEditingSize = editing
                            }
                        )
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                        Image(systemName: "star")
                    }
                }
                Spacer()
                ButtonsViews()
            }
            .padding(EdgeInsets(top: 16, leading: 50, bottom: 16, trailing: 50))
        }
        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
        .padding(EdgeInsets(top: 32, leading: 32, bottom: 32, trailing: 32))
    }
}
