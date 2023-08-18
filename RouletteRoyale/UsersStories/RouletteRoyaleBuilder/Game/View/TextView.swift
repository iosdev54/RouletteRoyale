//
//  TextView.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 18.08.2023.
//

import SwiftUI

struct TextView: View {
    @State var mode: Int
    @State var text: String
    
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        if (mode == 1) || (mode == 2) || (mode == 3) {
            Text(text)
                .rotationEffect(.degrees(270), anchor: .center)
                .foregroundColor(.white)
                .frame(width: width, height: height)
                .border(.white, width: 1)
            
                    } else if (mode == 4) || (mode == 5) {
                        Text(text)
                            .foregroundColor(.white)
                            .frame(width: width, height: height)
                            .border(.white, width: 1)
        }

                    
                
        }
        
}

//struct TextView_Previews: PreviewProvider {
//    static var previews: some View {
//        TextView(mode: 0, text: "f")
//    }
//}
