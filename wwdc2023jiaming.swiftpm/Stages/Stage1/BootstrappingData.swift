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
let welcome = "Welcome to iCEO: The Future of Apple! part(1/2)"
let welcome2 = """
In this game, you'll take on the role of Apple's CEO, making strategic decisions to steer the company towards unprecedented success!

Are you ready to walk in the footsteps of tech giants like Steve Jobs and Tim Cook? Let's get started!
"""

let IntroDescription = """
In each round, you can choose between two types of operations: the "MacSafe" and the "iRisky."

The game consists of 20 exciting rounds, where you'll face unique challenges and make crucial choices to maximize the company's earnings.
"""

let opt1Description = """
The MacSafe option represents a low-risk, low-reward strategy, with a $50 return and a 90% success rate.

Think of it as a trusty MacBook charger—steady and reliable!
"""

let opt2Description = """
The iRisky option is your high-risk, high-reward play, with a whopping $200 return but only a 60% success rate.

This bold move is like launching a groundbreaking new product, such as the original iPhone, which could either revolutionize the industry or flop spectacularly.
"""

let alarmDescription = """
If you succeed in your chosen operation, your earnings will be added to a temporary income pool.

⚠️But beware, if you fail, you'll lose all the earnings from that round and move on to the next challenge, with your tail between your legs.
"""

let endDescription = """
If you're feeling cautious, you can choose to end the round early and add your temporary earnings to your total income.

Think of it as playing it safe with a tried-and-true product update, like the ever-popular iPhone SE.
"""

let goalDescription = """
Your ultimate goal is to maximize your total earnings over 20 rounds.

The more you earn, the more you can invest in developing cutting-edge products and services, making Apple an even more dominant force in the tech world!
"""

let lastDescription = """
So, future iCEO, are you ready to take the reins and make your mark on Apple's legacy?

Channel your inner Steve Jobs, don your black turtleneck, and prepare to make decisions that will shape the company's future.

Good luck!
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
