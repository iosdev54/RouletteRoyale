//
//  CustomButton.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 16.08.2023.
//

import SwiftUI

private extension Constants {
    static let buttonTextForegroundColor: Color = .white
    static let buttonCornerRadius: CGFloat = 10
    static let buttonShadow: CGFloat = 5
    static let progressViewScale: CGFloat = 1.5
    static let progressViewTint: Color = .white
}

struct CustomButton: View {
    let isLoading: Bool
    let title: String
    let color: Color
    let completion: () -> Void
    
    init(isLoading: Bool = false, title: String, color: Color, completion: @escaping () -> Void) {
        self.isLoading = isLoading
        self.title = title
        self.color = color
        self.completion = completion
    }
    
    @ViewBuilder
    private var content: some View {
        if isLoading {
            loadingButton
        } else {
            regularButton
        }
    }
    
    private var loadingButton: some View {
        ProgressView()
            .scaleEffect(Constants.progressViewScale)
            .tint(Constants.progressViewTint)
            .foregroundColor(color)
            .padding()
            .frame(maxWidth: .infinity)
            .background(color)
            .cornerRadius(Constants.buttonCornerRadius)
    }
    
    private var regularButton: some View {
        Text(title)
            .foregroundColor(Constants.buttonTextForegroundColor)
            .padding()
            .frame(maxWidth: .infinity)
            .background(color)
            .cornerRadius(Constants.buttonCornerRadius)
    }
    
    var body: some View {
        Button(action: completion) {
            content
        }
        .shadow(radius: Constants.buttonShadow)
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(isLoading: true, title: "Log In", color: .blue, completion: {})
    }
}
