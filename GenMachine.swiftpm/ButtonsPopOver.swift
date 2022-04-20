//
//  NavButtons.swift
//  m
//
//  Created by Cassio Dezotti on 19/04/22.
//

import SwiftUI

struct ButtonsPopOver: View {
    let icon: String
    let action: () -> Void
    let longPressView: AnyView
    let iconSize: CGFloat
    @State private var showPopover: Bool = false
    
    
//    init(@ViewBuilder content: () -> Content) {
//        self.longPressView = content()
//        self.icon = ""
//        self.action = {}
//    }
    
    var body: some View {
        Button(action: action, label: {
            Image(systemName: icon)
                .renderingMode(.template)
                .foregroundColor(Color(red: 28/255, green: 28/255, blue: 20/255))
                .font(.system(size: iconSize))
        }).popover(
            isPresented: self.$showPopover,
            attachmentAnchor: .rect(.bounds),
            content: {
                self.longPressView
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
                action()
            })

    }
}
