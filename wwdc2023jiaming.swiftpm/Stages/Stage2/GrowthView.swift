//
//  SecondPartView.swift
//  My App
//
//  Created by 刘佳铭 on 2023/3/23.
//

import SwiftUI

struct GrowthView: View {
    @State private var companySize: CGFloat = 100
    @State private var currentMoney: Int = 0
    @State private var overallIncome: Int = 0
    @State private var riskMeter: Double = 0.05
    @State private var companyName: String = "Your Company"
    let stageCompleted: () -> Void

    let decisionButtons = [
        ("Invest in R&D", 0.1, 100),
        ("Hire Employees", 0.05, 50),
        ("Cut Costs", 0.01, 10),
        ("Launch New Product", 0.2, 200)
    ]
    
    var body: some View {
        VStack {
            Text(companyName)
                .font(.largeTitle)
                .bold()
                .padding(.top)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Current Money: $\(currentMoney)")
                    Text("Overall Income: $\(overallIncome)")
                }
                .padding(.leading)
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Risk Meter:")
                    ProgressBar(value: $riskMeter)
                        .frame(height: 20)
                }
                .padding(.trailing)
            }
            .padding(.bottom)
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue)
                .frame(width: companySize, height: companySize)
                .padding(.bottom)
            
            Spacer()
            
            VStack {
                ForEach(decisionButtons, id: \.0) { decision in
                    Button(decision.0) {
                        riskMeter = decision.1
                        let randomValue = Double.random(in: 0...1)
                        if randomValue <= riskMeter {
                            companySize = companySize - CGFloat(decision.2/5)
                            currentMoney -= decision.2
                        } else {
                            companySize = companySize + CGFloat(decision.2/5)
                            currentMoney += decision.2
                        }
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.bottom)
                }
                Button("Complete Stage") {
                                stageCompleted()
                            }
            }
            .padding(.bottom)
        }
    }
}

struct ProgressBar: View {
    @Binding var value: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.3))
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.green)
                    .frame(width: CGFloat(value) * geometry.size.width)
            }
        }
    }
}

//struct GrowthView_Previews: PreviewProvider {
//    static var previews: some View {
//        GrowthView()
//    }
//}
