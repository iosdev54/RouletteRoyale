//
//  CustomButton.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 16.08.2023.
//

import SwiftUI

struct CustomButton: View {
    @Binding var isLoading: Bool
    
    let title: String
    let color: Color
    let completion: () -> Void
    
    var body: some View {
        Button(action: completion) {
            if isLoading {
                ProgressView()
                    .scaleEffect(1.5)
                    .tint(.white)
                    .foregroundColor(color)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(color.opacity(0.9))
                    .cornerRadius(10)
            } else {
                Text(title)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(color)
                    .cornerRadius(10)
            }
        }
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(isLoading: .constant(true), title: "Log In", color: .blue, completion: {})
    }
}
