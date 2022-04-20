//
//  File.swift
//  m
//
//  Created by Cassio Dezotti on 19/04/22.
//

import Foundation
import SwiftUI

struct OnBoardingView: View{
    
//    @StateObject var launchView = ObservableLaunchView()
    @Binding var isPresented: Bool
    
    
    
    var body: some View{
        
        VStack {
            Spacer(minLength: 140)
            
            Text("Welcome! \nThis is GenMachine")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            DetailItem(icon: "person", imageColor: .blue, title: "Author", description: "This app was design and develop by \nCássio Dezotti.")
            DetailItem(icon: "text.book.closed", imageColor: .red, title: "Learn", description:"If you wanna learn a little bit about \ngenerative art, long press the icons, \nfor full information about the feature.")
            DetailItem(icon: "magnifyingglass", imageColor: .orange, title: "Explore", description: "Each feature is unique, and \ncombining all of them you are able to \ncreate thousents of art pieces.")
            Spacer(minLength: 50)
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
                    .padding(.top, 50)
            }
            Spacer(minLength: 140)
            
            
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



