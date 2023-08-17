//
//  RatingView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 17.08.2023.
//

import SwiftUI

struct RatingView: View {
    @StateObject private var viewModel = RatingViewModel()
    
    
    var body: some View {
        ScrollView {
            
            
            LazyVStack(spacing: 16) {
                ForEach(viewModel.users) { user in
                    UserView(userData: user)
                }
            }
            .padding()
        }
        .onAppear(perform: viewModel.getAllUsersData)
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView()
    }
}
