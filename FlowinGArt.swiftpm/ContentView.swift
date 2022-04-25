import SwiftUI




struct ContentView: View {
    @State var showInfoModalView: Bool = true
    
    
    @State var sliderNumberParticle = 50.0
    @State var sliderSizeRange: ClosedRange<Float> = 20...50
    @State var particles: Int = 50
    @State var clicouRefresh: Bool = false
    @State var clicouRandom: Bool = false
    @State var brushSelected: Int = 0
    @State var pathSelected: Int = 0
    @State var colorSelected: Int = 0
    
    @State var canvasSize: CGFloat = 0
    
    func refreshClick() {
        clicouRefresh.toggle()
    }
    func randomClick() {
        clicouRandom.toggle()
    }
    
    var body: some View {
        
        
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    
                    ArtView(
                        numberOfParticles: self.$sliderNumberParticle,
                        refresh: self.$clicouRefresh,
                        random: self.$clicouRandom,
                        size: self.$sliderSizeRange,
                        paused: self.$showInfoModalView,
                        pathPatternSelected: self.$pathSelected,
                        colorPatternSelected: self.$colorSelected,
                        brushPatternSelected: self.$brushSelected
                    )
                    .frame(height: geometry.size.height * ( geometry.size.height > 1100 ?  0.65 : geometry.size.height > geometry.size.width ? 0.55 : 0.45))
                    Spacer()
                    ControlPainel(
                        sliderRange: self.$sliderSizeRange,
                        number: self.$sliderNumberParticle,
                        pathSelected: self.$pathSelected,
                        colorSelected: self.$colorSelected,
                        brushSelected: self.$brushSelected
                    )
                    .frame(height: geometry.size.height * ( geometry.size.height > geometry.size.width ?  0.3 : 0.4))
                    .navigationBarItems(
                        trailing:
                            HStack {
                                ButtonsPopOver(icon: "info.circle",
                                               popoverView:
                                                AnyView(
                                                    VStack {
                                                        Text("Credits")
                                                            .font(.largeTitle)
                                                            .padding(EdgeInsets(top: 20, leading: 0, bottom: 15, trailing: 0))
                                                        Text("Design and Develop ")
                                                            .font(.headline.bold())
                                                            .padding(EdgeInsets(top: 15, leading: 50, bottom: 0, trailing: 50))
                                                        Text("by Cássio Dezotti")
                                                            .font(.callout)
                                                            .font(.callout)
                                                        Text("Art and Algorithm inspiration")
                                                            .font(.headline)
                                                            .padding(EdgeInsets(top: 15, leading: 50, bottom: 0, trailing: 50))
                                                        Text("by Tylor Hobbs - Fidenza")
                                                            .font(.callout)
                                                        Text("Thanks")
                                                            .font(.headline)
                                                            .padding(EdgeInsets(top: 15, leading: 50, bottom: 0, trailing: 50))
                                                        Text("frinds, family and art lovers")
                                                            .font(.callout)
                                                        Spacer()
                                                        
                                                    }.frame(width: UIScreen.main.bounds.size.width/1.5, height: UIScreen.main.bounds.size.height/4, alignment: .center)
                                                    
                                                )
                                               
                                               , iconSize: 20)
                            }
                    )
                    .navigationBarItems(
                        trailing:
                            HStack {
                                Button(action: randomClick, label: {
                                    Image(systemName: "shuffle")
                                        .renderingMode(.template)
                                        .foregroundColor(Color("iconBar"))
                                        .font(.system(size: 20))
                                })
                            }
                    )
                    .navigationBarItems(
                        trailing:
                            HStack {
                                Button(action: refreshClick, label: {
                                    Image(systemName: "arrow.clockwise")
                                        .renderingMode(.template)
                                        .foregroundColor(Color("iconBar"))
                                        .font(.system(size: 20))
                                })
                            }
                    )
                    .navigationBarTitleDisplayMode(.inline)
                    Spacer()
                }
            }
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
        .sheet(isPresented: self.$showInfoModalView) {
            OnBoardingView(isPresented: self.$showInfoModalView)
        }
        
        
        
        
    }
    
}

