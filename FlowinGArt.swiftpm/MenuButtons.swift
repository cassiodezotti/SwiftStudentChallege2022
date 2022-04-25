//
//  MenuButtons.swift
//  GenMachine
//
//  Created by Cassio Dezotti on 22/04/22.
//

import SwiftUI

struct MenuButtons: View {
    
    let icon: String
    let popoverView: AnyView
    let iconSize: CGFloat
    let options: [Text]
    
    @State private var popoverFirstTime = true
    @State private var showPopover: Bool = false
    @State private var selectedOption = 0
    
    @Binding var selected: Int
    
    
    var body: some View {
        self.popoverFirstTime ?
        AnyView(Menu(content: {
            Picker(selection: $selectedOption, label: Image(systemName: icon)) {
                ForEach(0..<options.count){
                    self.options[$0]
                }
            }
        }, label: {
            Image(systemName: icon)
                .renderingMode(.template)
                .foregroundColor(Color("icon"))
                .font(.system(size: iconSize))
            
        }, primaryAction: {
            self.showPopover = true
            
        }).popover(
            isPresented: self.$showPopover,
            attachmentAnchor: .rect(.bounds),
            content: {
                self.popoverView
                    .padding()
            }
        ).onChange(of: self.showPopover){newValue in
            if(!newValue){
                self.popoverFirstTime = false
            }
            
        }
        )
        :
        AnyView(
            Menu(content: {
                Picker(selection: $selectedOption, label: Image(systemName: icon)) {
                    ForEach(0..<options.count){
                        self.options[$0]
                    }
                }
            }, label: {
                Image(systemName: icon)
                    .renderingMode(.template)
                    .foregroundColor(Color("icon"))
                    .font(.system(size: iconSize))
                
            }
                ).onChange(of: selectedOption){ newOption in
                    self.selected = selectedOption
                }
        )
        
    }
}
