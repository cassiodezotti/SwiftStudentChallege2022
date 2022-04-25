//
//  ButtonsPopOver.swift
//  
//
//  Created by Cassio Dezotti on 19/04/22.
//

import SwiftUI

struct ButtonsPopOver: View {
    let icon: String
    let popoverView: AnyView
    let iconSize: CGFloat
    @State var showPopover: Bool = false
    
    
    var body: some View {
        Button(action: {
            self.showPopover = true
            
            
        }, label: {
            Image(systemName: icon)
                .renderingMode(.template)
                .foregroundColor(Color("iconBar"))
                .font(.system(size: iconSize))
        }).popover(
            isPresented: self.$showPopover,
            attachmentAnchor: .rect(.bounds),
            content: {
                self.popoverView
                    .padding()
            }
        )
        
    }
}
