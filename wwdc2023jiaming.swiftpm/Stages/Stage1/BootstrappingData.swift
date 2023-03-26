//
//  File.swift
//  
//
//  Created by 刘佳铭 on 2023/3/23.
//

import Foundation
import SwiftUI
let welcome = "Welcome to the Bootstrapping stage!"
let IntroDescription = """
🥳This is where your startup journey begins.

🤑You have limited funds, and your decisions will focus on laying the groundwork for your company's future.

⚠️Be cautious, as the wrong choices could quickly deplete your resources.
"""

let choicesDescription = "Focus on basic business decisions like selecting a niche, finding suppliers, and creating a minimum viable product (MVP)."

let riskDescription = "Low to moderate risks, with the possibility of setbacks like supplier issues or initial product failure."

let introArr: [[String]] = [
    ["Action", "reward", "loss", "Success rate"],
    ["Finding niche", "$50", "$0", "90%"],
    ["Finding suppliers", "$200", "-$100", "70%"]
]
let gradient = LinearGradient(gradient: Gradient(colors: [Color("stage1Green"), Color("stage1Pink")]), startPoint: .topLeading, endPoint: .bottomTrailing)

let succeedEmoji = ["😃", "🥳", "🥰", "🤭", "🤤", "😘", "😲","😋"]
let resetEmoji = "🙌"
let failEmoji: [String] = ["😩","🥺","😖","🥲","😤","☹️"]

