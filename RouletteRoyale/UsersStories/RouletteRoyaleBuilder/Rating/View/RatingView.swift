//
//  RatingView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 17.08.2023.
//

import SwiftUI

private extension Constants {
    static let dataViewSpacing: CGFloat = 16
    static let loadingViewSpacing: CGFloat = 25
    static let progressViewScale: CGFloat = 2
    static let progressViewTint: Color = .yellow
    static let textColor: Color = .white.opacity(0.8)
    static let textFont: Font = .title
}

struct RatingView: View {
    @StateObject private var viewModel = RatingViewModel()
    @EnvironmentObject var userData: UserData
    
    private var filteredUsers: [UserData] {
        viewModel.users
            .filter { $0.id != userData.id }
            .sorted()
    }
    
    private var loadingView: some View {
        HStack(spacing: Constants.loadingViewSpacing) {
            ProgressView()
                .scaleEffect(Constants.progressViewScale)
                .tint(Constants.progressViewTint)
            
            Text("Loading...")
                .font(Constants.textFont)
                .foregroundColor(Constants.textColor)
        }
    }
    
    private var dataView: some View {
        ScrollView {
            LazyVStack(spacing: Constants.dataViewSpacing) {
                ForEach(filteredUsers, content: { user in
                    UserView(userData: user, background: .material(.thin))
                })
                .offset(y: 10)
            }
        }
    }
    
    private var noDataView: some View {
        Text("No data")
            .font(Constants.textFont)
            .foregroundColor(Constants.textColor)
    }
    
    var body: some View {
        VStack {
            UserView(userData: userData)
                .animation(.easeInOut, value: userData)
                .padding()
            
            Group {
                switch viewModel.loadingState {
                case .loading:
                    loadingView
                        .frame(maxHeight: .infinity)
                case .hasData:
                    dataView
                        .padding(.horizontal)
                case .noData:
                    noDataView
                        .frame(maxHeight: .infinity)
                }
            }
        }
        .onAppear(perform: viewModel.getAllUsersData)
        .alert(item: $viewModel.error) { error in
            Alert(title: Text(error.title), message: Text(error.message))
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Constants.Images.gameBackground
                .resizable()
                .ignoresSafeArea()
            
            RatingView()
                .environmentObject(UserData())
        }
    }
}
