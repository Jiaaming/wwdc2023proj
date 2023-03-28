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
let welcome = "Welcome to the Bootstrapping stage!"
let IntroDescription = """
🥳This is where your startup journey begins.

You start with 0 dollars and will play through 10 rounds.

In each round, you'll have the chance to increase your earnings by making a choice between two options.
"""

let choicesDescription = "Focus on basic business decisions like selecting a niche, finding suppliers, and creating a minimum viable product (MVP)."

let riskDescription = "Low to moderate risks, with the possibility of setbacks like supplier issues or initial product failure."
let goalDescription = """
🙌The goal of the game is to make the best decisions to maximize your earnings over the 10 rounds.

😲Will you take risks for big rewards or play it safe to avoid losses? It's up to you! Good luck, and have fun!
"""
let opt1Description = """
🤤The first option gives you a 90% chance of success.

😃If you succeed, you'll earn 50 dollars for this round, and your total earnings will increase.

🥺If you fail, you won't lose any money, but you'll earn nothing for this round and move on to the next round.
"""
let opt2Description = """
🤩The second option is a bit riskier, with a 60% chance of success.

😃If you succeed, you'll earn a whopping 200 dollars for this round!

🥺However, if you fail, you'll lose 100 dollars from your total earnings, and then move on to the next round.
"""

let endDescription = """
🤔At any point during a round, you can choose to end the round without attempting either option.

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
