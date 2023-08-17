//
//  UserView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 16.08.2023.
//

import SwiftUI

struct UserView: View {
    let user: UserData?
    
    var body: some View {
        HStack(spacing: 20) {
            avatarView
            
            Text(user?.name ?? "Unknown")
                .minimumScaleFactor(0.7)
                .font(.title)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(String(user?.chips ?? 0000))
                .font(.largeTitle)
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
                Text(String(user?.name.prefix(1) ?? "U"))
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: UserData.mock)
    }
}
