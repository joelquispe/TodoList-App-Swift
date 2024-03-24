//
//  ToastView.swift
//  app-tasks-swiftui
//
//  Created by joel on 26/11/23.
//

import Foundation
import SwiftUI
struct ToastView: View {
    let message: String
    let duration: TimeInterval

    @Binding var isPresented: Bool

    @State private var offset:CGFloat = 1000
    
    var body: some View {
        Text(message)
            .padding()
            .foregroundColor(.white)
            .background(Color.black)
            .cornerRadius(10)
            //.opacity(isPresented ? 1.0 : 0.0)
            .offset(x:0,y:offset)
            .onAppear {
                
              
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    withAnimation(.spring()) {
                        
                        isPresented = false
                        offset = 1000

                    }
                }
                
            }
        
    }
}
