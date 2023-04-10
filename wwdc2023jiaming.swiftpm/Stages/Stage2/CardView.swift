//
//  File.swift
//  
//
//  Created by 刘佳铭 on 2023/3/28.
//

import SwiftUI

struct CardView: View {
    var value: Int
    var isSelected: Bool
    var emoji: String
    var width: CGFloat
    var height: CGFloat
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(isSelected ? Color("stage1Green") : .white) // Change fill color based on isSelected
            
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white, lineWidth: 2)
                .shadow(color: Color.black.opacity(0.3), radius: 2, x: 2, y: 2)
        }
        .frame(width: width, height: height)
        .overlay(
            VStack {
                Text(emoji)
                    .font(.system(size:height/2))
                Text("\(value)")
                    .font(.system(size:width/3))
                
            }
                .foregroundColor(.black)
        )
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(value: 10, isSelected: true,emoji: "🧑🏻‍💻", width: 300,height: 400)
    }
}
