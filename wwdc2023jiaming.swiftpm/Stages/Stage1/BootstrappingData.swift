//
//  File.swift
//  
//
//  Created by 刘佳铭 on 2023/3/23.
//

import Foundation
import SwiftUI
struct RoundData {
    var successCount: Int = 0
    
    mutating func updateSuccess(success: Bool) {
        if success {
            successCount += 1
        }
    }
}
let welcome = "Welcome to your Apple Adventures Part 1!"
let IntroDescription = """
Imagine that you step into the shoes of the CEO of Apple, one of the world's most innovative and successful technology companies.

As you embark on this thrilling journey, you'll be tasked with making critical decisions that will shape the future of the company and its groundbreaking products!
"""

let lastDescription = """
You start with 0 dollars and will play through 20 rounds.

At the end of the game, you will receive an accurate review

Are you ready to accept the challenge and steer Apple towards a prosperous future? 🥳Put on your CEO hat and begin your Apple Adventures today! Good luck!
"""

let choicesDescription = "Focus on basic business decisions like selecting a niche, finding suppliers, and creating a minimum viable product (MVP)."

let riskDescription = "Low to moderate risks, with the possibility of setbacks like supplier issues or initial product failure."
let goalDescription = """
🙌The goal of the game is to make the best decisions to maximize your earnings over the 10 rounds.

😲Will you take risks for big rewards or play it safe to avoid losses? It's up to you! Good luck, and have fun!
"""
let opt1Description = """
A low-risk approach that nurture existing products and maintain company stability.

🤤 90% chance of success

😃 Success earns $50 for the round, increasing your total earnings

🥺 Failure results in no loss, but no earnings for the round, and you'll proceed to the next round
"""
let opt2Description = """
A high-risk, high-reward strategy that  innovate and venture into new markets or technologies.

🤩 60% chance of success

😃 Success earns a huge $200 for the round

🥺 Failure results in a $100 loss from your total earnings, and you'll advance to the next round
"""

let endDescription = """
🤔At any point during a round, you can choose "Harvest Profits" to end the round without attempting either option.

🫣This means you won't earn any money for the round, but you also won't lose any money. Then, you'll proceed to the next round.
"""

let introArr: [[String]] = [
    ["Action", "reward", "loss", "Success rate"],
    ["Finding niche", "$50", "$0", "90%"],
    ["Finding suppliers", "$200", "-$100", "70%"]
]
let gradient = LinearGradient(gradient: Gradient(colors: [Color("stage1Green"), Color("stage1Pink")]), startPoint: .topLeading, endPoint: .bottomTrailing)

let succeedEmoji = ["😃", "🥳", "🥰", "🤭", "🤤", "😘", "😲","😋"]
let resetEmoji = "🙌"
let failEmoji: [String] = ["😩","🥺","😖","🥲","😤","☹️"]

struct GrowingButton: ButtonStyle {
    var isDisabled: Bool
    var color: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(isDisabled ? Color.gray : color)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
