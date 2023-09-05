//
//  UserView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 16.08.2023.
//

import SwiftUI

struct UserView: View {
    private enum UserViewConstants {
        static let dataViewSpacing: CGFloat = 20
        static let loadingViewSpacing: CGFloat = 40
        static let loadingViewScale: CGFloat = 2
        static let avatarBackgroundColor = Color.yellow
        static let dollarImage = Constants.Images.dollarImage
    }
    
    @ObservedObject var userData: UserData
    
    var background: BackgroundStyle = .material(.ultraThinMaterial)
    
    var body: some View {
        Group {
            if userData.isDataAvailable {
                dataView
            } else {
                loadingView
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 80)
        .background(background)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 5)
    }
    
    private var avatarCircleView: some View {
        Circle()
            .fill(UserViewConstants.avatarBackgroundColor)
            .overlay {
                Text(String(userData.name.prefix(1)))
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
    }
    
    private var dataView: some View {
        HStack(spacing: UserViewConstants.dataViewSpacing) {
            if userData.isDataAvailable {
                avatarCircleView
                    .layoutPriority(1)
                
                Text(userData.name)
                    .minimumScaleFactor(0.8)
                    .lineLimit(1)
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(String(userData.chips))
                    .lineLimit(1)
                    .font(.title)
                    .foregroundColor(.yellow)
                    .layoutPriority(1)
                
                UserViewConstants.dollarImage
                    .resizable()
                    .scaledToFit()
                    .layoutPriority(1)
            }
        }
    }
    
    private var loadingView: some View {
        HStack(spacing: UserViewConstants.loadingViewSpacing) {
            ProgressView()
                .scaleEffect(UserViewConstants.loadingViewScale)
            
            Text("Loading...")
                .font(.title)
                .foregroundColor(.secondary)
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Constants.Images.gameBackground
                .resizable()
                .ignoresSafeArea()
            
            UserView(userData: UserData())
                .padding(.horizontal)
        }
    }
}
