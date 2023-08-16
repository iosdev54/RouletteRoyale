//
//  UserView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 16.08.2023.
//

import SwiftUI

struct UserView: View {
    let name: String
    var balance: Int
    
    var body: some View {
        HStack(spacing: 20) {
            avatarView
            
            Text(name)
                .font(.largeTitle)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(String(balance))
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
                Text(String(name.prefix(1)))
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(name: "Ivan", balance: 3400)
    }
}
