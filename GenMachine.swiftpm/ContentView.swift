import SwiftUI




struct ContentView: View {
    @State private var text = ""
    @State private var showPopover: Bool = false
    @State var showInfoModalView: Bool = true
    
    @State private var number = 50.0
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .cornerRadius(20)
                    .padding(EdgeInsets(top: 32, leading: 32, bottom: 0, trailing: 32))
                
                    .navigationBarItems(
                        trailing:
                            HStack {
                                ButtonsPopOver(icon: "info.circle", action: {print("clicou info")}, longPressView: AnyView(Text("info")), iconSize: 20)
                            }
                    )
                    .navigationBarItems(
                        trailing:
                            HStack {
                                ButtonsPopOver(icon: "shuffle", action: {print("clicou shuffe")}, longPressView: AnyView(Text("shuffle")), iconSize: 20)
                            }
                    )
                    .navigationBarItems(
                        trailing:
                            HStack {
                                ButtonsPopOver(icon: "arrow.clockwise", action: {print("clicou refresh")}, longPressView: AnyView(Text("refresh")), iconSize: 20)
                            }
                    )
                    .navigationBarItems(
                        trailing:
                            HStack {
                                ButtonsPopOver(icon: "pause", action: {print("clicou pause")}, longPressView: AnyView(Text("pause")), iconSize: 20)
                            }
                    )
                
                
                
                ControlPainel()
                    .padding(EdgeInsets(top: 120, leading: 0, bottom: 0, trailing: 0))
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
        HStack(spacing: 20){
            ButtonsPopOver(icon: "arrow.triangle.swap", action: {print("clicou info")}, longPressView: AnyView(Text("info")), iconSize: 30)
            
            ButtonsPopOver(icon: "paintbrush", action: {print("clicou info")}, longPressView: AnyView(Text("info")), iconSize: 30)
            ButtonsPopOver(icon: "line.3.crossed.swirl.circle", action: {print("clicou info")}, longPressView: AnyView(Text("info")), iconSize: 30)
            
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
    }
    
}



struct ControlPainel: View {
    
    @State var sliderPosition: ClosedRange<Float> = 30...80
    @State private var number = 50.0
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
                        RangedSliderView(value: $sliderPosition, bounds: 0...100)
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
