//
//  OnBoardingView.swift
//
//
//  Created by Cassio Dezotti on 19/04/22.
//

import Foundation
import SwiftUI

struct OnBoardingView: View{
    
    @Binding var isPresented: Bool
    
    
    
    var body: some View{
        
        VStack {
            Spacer(minLength: 100)
            
            Text("Welcome! \nThis is FlowinGArt")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            DetailItem(icon: "person", imageColor: Color.blue, title: "Author", description: "This application was designed and \ndeveloped with care by Cássio Dezotti.")
            
            DetailItem(icon: "text.book.closed", imageColor: Color.red, title: "Learn", description:"The first time the buttons are pressed \nyou will see a popover window telling \nyou about the pressed feature, this is \nto guide you and help you understand \na little more about the generative art.")
            DetailItem(icon: "magnifyingglass", imageColor: Color.orange, title: "Explore", description: "Each feature is unique, and \ncombining all of them you are able to \ncreate thousents of art pieces. \nExplore them all!")
            Spacer(minLength: 30)
            Button(action: {
                UserDefaults.standard.set(true, forKey: "LaunchBefore")
                withAnimation(){
                    self.isPresented = false
                }
            })
            {
                Text("Let's Create!")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(width: 385, height: 60)
                    .background(Color.blue)
                    .cornerRadius(15)
                    .padding(.top, 40)
            }
            Spacer(minLength: 100)
            
            
        }
        
    }
}
struct DetailItem: View {
    var icon: String
    var imageColor: Color
    var title: String
    var description: String
    
    var body: some View {
        Spacer(minLength: 50)
        HStack(spacing: 19){
            Image(systemName: icon )
                .renderingMode(.template)
                .foregroundColor( imageColor)
                .font(.system(size: 60))
            VStack(alignment: .leading, spacing: 5){
                Text(title)
                    .font(.title3)
                    .bold()
                Text(description)
                    .font(.body)
                    .bold()
                    .foregroundColor(.secondary)
            }
        }
        
    }
}



