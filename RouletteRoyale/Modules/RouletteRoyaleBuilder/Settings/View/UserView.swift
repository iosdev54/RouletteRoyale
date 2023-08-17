//
//  UserView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 16.08.2023.
//

import SwiftUI

struct UserView: View {
    @ObservedObject var userData: UserData
    
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
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 10)
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
