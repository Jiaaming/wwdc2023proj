//
//  File.swift
//  
//
//  Created by 刘佳铭 on 2023/3/24.
//
import SwiftUI
struct EmojiCircle: View {
    let emoji: String
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 2)
            Text(emoji)
                .font(.system(size: 20))
        }
        .frame(width: 40, height: 40)
    }
}

struct BackgroundView: View {
    @State private var animationPhase = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Circles with emojis
                EmojiCircle(emoji: "😀")
                    .position(x: geometry.size.width * 0.3, y: geometry.size.height * 0.3)
                EmojiCircle(emoji: "😎")
                    .position(x: geometry.size.width * 0.7, y: geometry.size.height * 0.3)
                EmojiCircle(emoji: "🥳")
                    .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.7)
                
                // Connecting lines
                Path { path in
                    path.move(to: CGPoint(x: geometry.size.width * 0.3, y: geometry.size.height * 0.3))
                    path.addLine(to: CGPoint(x: geometry.size.width * 0.7, y: geometry.size.height * 0.3))
                    path.addLine(to: CGPoint(x: geometry.size.width * 0.5, y: geometry.size.height * 0.7))
                    path.addLine(to: CGPoint(x: geometry.size.width * 0.3, y: geometry.size.height * 0.3))
                }
                .stroke(lineWidth: 2)
            }
            .rotationEffect(.degrees(animationPhase))
            .onAppear {
                withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                    animationPhase = 360
                }
            }
        }
    }
}
