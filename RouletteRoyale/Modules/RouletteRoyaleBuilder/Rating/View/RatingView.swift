//
//  RatingView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 17.08.2023.
//

import SwiftUI

struct RatingView: View {
    @StateObject private var viewModel = RatingViewModel()
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack {
            UserView(userData: userData, background: .gray)
                .animation(.easeInOut, value: userData)
                .padding()
            
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(filteredUsers, content: { user in
                        UserView(userData: user)
                    })
                    .offset(y: 10)
                }
                .padding(.horizontal)
            }
        }
        .onAppear(perform: viewModel.getAllUsersData)
        .alert(item: $viewModel.error) { error in
            Alert(title: Text(error.title), message: Text(error.message))
        }
    }
    
    private var filteredUsers: [UserData] {
        viewModel.users
            .filter { $0.id != userData.id }
            .sorted()
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView()
            .environmentObject(UserData())
    }
}
