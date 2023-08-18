//
//  UserView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 16.08.2023.
//

import SwiftUI

struct UserView: View {
    enum BackgroundColor {
        case white
        case gray
        
        var color: Color {
            switch self {
            case .white:
                return Color.white
            case .gray:
                return Color.teal
            }
        }
    }
    
    @ObservedObject var userData: UserData
    var background: BackgroundColor = .white
    
    var body: some View {
        HStack(spacing: 20) {
            avatarView
            
            Text(userData.name)
                .minimumScaleFactor(0.7)
                .lineLimit(1)
                .font(.title)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(String(userData.chips))
                .lineLimit(1)
                .font(.title)
                .foregroundColor(.yellow)
            
            Image("dollar")
                .resizable()
                .scaledToFit()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 80)
        .background(background.color)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 5)
    }
    
    
    private var avatarView: some View {
        Circle()
            .fill(.yellow)
            .overlay {
                Text(String(userData.name.prefix(1)))
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(userData: UserData())
    }
}
