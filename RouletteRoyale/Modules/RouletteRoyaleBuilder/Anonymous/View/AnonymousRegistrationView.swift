//
//  AnonymousRegistrationView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 16.08.2023.
//

import SwiftUI

struct AnonymousRegistrationView: View {
    @StateObject private var viewModel: AnonymousRegistrationViewModel
    
    init(onSuccess: @escaping () -> Void) {
        self._viewModel = StateObject(wrappedValue: AnonymousRegistrationViewModel(onSuccess: onSuccess))
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Anonymous Registration")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            CustomButton(isLoading: $viewModel.isLoading, title: "Register Anonymously", color: .blue, completion: viewModel.registerAnonymously)
                .disabled(viewModel.isLoading)
                .animation(.easeInOut, value: viewModel.isLoading)
        }
        .padding()
        .alert(item: $viewModel.error) { error in
            Alert(title: Text(error.title), message: Text(error.message))
        }
    }
}

struct AnonymousRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        AnonymousRegistrationView(onSuccess: {})
    }
}
