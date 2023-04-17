//
//  File.swift
//  
//
//  Created by 刘佳铭 on 2023/3/25.
//
import SwiftUI

import Charts
let cong = """
As the CEO, you made some tough decisions and led Apple through 20 exhilarating rounds. Let's take a look at how you fared!
"""

struct Stage1GameOverView: View {
    let elapsedTime: TimeInterval
    let succeedTimes: Int
    let failTimes: Int
    let opt1SucceedTimes: Int
    let opt1FailTimes: Int
    let opt2SucceedTimes: Int
    let opt2FailTimes: Int
    let stopTimes: Int
    let overallIncome: Int
    let eachRoundsLastArray: [Int]
    let incomeArray: [Int]
    
    
    @State private var riskTendency: String = ""
    @State private var decisiveness: String = ""
    @State private var incomeEvaluation: String = ""
    
    
    @State private var showPopover1 = false
    @State private var showPopover2 = false
    @State private var showPopover3 = false

    @State private var selectedTab = 0
    
    func generateReportText(elapsedTime: TimeInterval, succeedTimes: Int, failTimes: Int, opt1SucceedTimes: Int, opt1FailTimes: Int, opt2SucceedTimes: Int, opt2FailTimes: Int, stopTimes: Int, overallIncome: Int) -> (decisiveness: String, incomeEvaluation: String, riskTendency: String) {
        
        let totalRounds = 20
   
        let chooseLowRiskTimes = opt1FailTimes + opt1SucceedTimes
        let chooseHighRiskTimes = opt2FailTimes + opt2FailTimes
        let totalChoices = chooseLowRiskTimes + chooseHighRiskTimes
        
        
        let riskTendency: String
        
        let decisiveness: String
        if elapsedTime < 60 {
            decisiveness = "lightning-fast decision maker"
        } else if elapsedTime < 90 {
            decisiveness = "deliberate thinker"
        } else {
            decisiveness = "slow and steady planner"
        }
        
        let incomeEvaluation: String
        if overallIncome >= 3300 {
            incomeEvaluation = "master of industry"
        } else if overallIncome >= 2800 {
            incomeEvaluation = "accomplished leader"
        } else if overallIncome >= 2300 {
            incomeEvaluation = "skilled manager"
        } else {
            incomeEvaluation = "promising up-and-comer"
        }
        
        let highRiskRatio = Double(chooseHighRiskTimes) / Double(totalChoices)
        
        if highRiskRatio >= 0.60 {
            riskTendency = "Brave Innovators"
        } else if highRiskRatio <= 0.40 {
            riskTendency = "Risk-Averse Tactician"
        } else {
            riskTendency = "Cautious Strategist"
        }
        
        return (decisiveness, incomeEvaluation, riskTendency)
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            VStack {
                ScrollView{
                    Spacer()
                    HStack{
                        Image("stage1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                        Text("🎉 Congratulations on completing \"iCEO: The Future of Apple!\" 🎉")
                            .font(.custom("Avenir", size: 50)
                                .weight(.bold))
                            .foregroundColor(Color("stage1Brown"))
                            .padding()
                    }
                    Divider()
                        .padding(20)
                    
                    Text(cong)
                        .font(.custom("Courier", size: 30))
                    //.foregroundColor(Color("stage1Pink"))
                        .padding()
                }
                .padding()
                
            }.tag(0)
            
            VStack{
                ScrollView{
                    if #available(iOS 16.0, *) {
                        VStack{
                            Spacer()
                            GroupBox ( "🏃🏻 Successful Actions per Round") {
                                Chart {
                                    ForEach(eachRoundsLastArray.indices, id: \.self) { index in
                                        LineMark(
                                            x: .value("Index", "\(index + 1)"),
                                            y: .value("Value", eachRoundsLastArray[index])
                                        )
                                    }
                                }
                                .foregroundColor(Color("stage1Brown"))
                                .frame(height: 250)
                            }
                            
                            
                            GroupBox ( "💰 Income Earned per Round") {
                                Chart {
                                    ForEach(incomeArray.indices, id: \.self) { index in
                                        LineMark(
                                            x: .value("Index", "\(index + 1)"),
                                            y: .value("Value", incomeArray[index])
                                        )
                                    }
                                }
                                
                                .foregroundColor(Color("stage1Green"))
                                .frame(height: 250)
                                
                            }
                            Text("You spend ⏱ \( String(format: "%.2f", elapsedTime)) seconds and earn 💰 \(overallIncome) dollars！Based on your performance, we'd say you're a")
                                .font(.custom("Courier", size: 30))

                            HStack{
                                Text(incomeEvaluation).bold()
                                    .font(.custom("Courier", size: 35))
                                Button(action: {
                                    showPopover1.toggle()
                                }) {
                                    Image(systemName: "questionmark.circle")
                                        .font(.title)
                                }.popover(isPresented: $showPopover1) {
                                    VStack(alignment: .leading) {
                                        Text("Detailed Explanation")
                                            .font(.title)
                                            .bold()
                                        Text(detailedExplain1)
                                            .font(.title2)
                                            .padding(.top)
                                    }

                                    .padding()
                                    .frame(width: 500, height: 400)
                                    //.background(.white)

                                }
                            }
                            Text("as well as a")
                                .font(.custom("Courier", size: 30))
                            HStack{
                                Text(decisiveness).bold()
                                    .font(.custom("Courier", size: 35))
                                
                                Button(action: {
                                    showPopover2.toggle()
                                }) {
                                    Image(systemName: "questionmark.circle")
                                        .font(.title)
                                }.popover(isPresented: $showPopover2) {
                                    VStack(alignment: .leading) {
                                        Text("Detailed Explanation")
                                            .font(.title)
                                            .bold()
                                        Text(detailedExplain2)
                                            .font(.title2)
                                            .padding(.top)
                                    }
                                    .padding()
                                    .frame(width: 500, height: 400)
                                    //.background(.white)

                                }
                            }
                        }
                        .padding()

                    }else{
                        Text("😢Please update ios16 to see the specific report")
                    }
                }
                
            }.tag(1)
            
            
            VStack{
                ScrollView{
                    if #available(iOS 16.0, *) {
                        VStack{
                            Spacer()
                            HStack{
                                GroupBox ( "Action - Stop ratio") {
                                    Chart{
                                        BarMark(
                                            x: .value("Index", "Action"),
                                            y: .value("Value", succeedTimes+failTimes)
                                        ).foregroundStyle(Color("stage1Pink"))
                                            .annotation {
                                                Text(String(format: "%.2f%%", (Double(succeedTimes+failTimes) / Double(succeedTimes+failTimes+stopTimes)) * 100))
                                            }
                                        
                                        BarMark(
                                            x: .value("Index", "Stop times"),
                                            y: .value("Value", stopTimes)
                                        ).foregroundStyle(Color("stage1Pink"))
                                            .annotation {
                                                Text(String(format: "%.2f%%", (Double(stopTimes) / Double(succeedTimes+failTimes+stopTimes)) * 100))
                                                
                                            }
                                    }
                                    .frame(height: 250)
                                }
                                
                                GroupBox ( "Overall Succeed-fail ratio") {
                                    Chart{
                                        BarMark(
                                            x: .value("Index", "success times"),
                                            y: .value("Value", succeedTimes)
                                        ).foregroundStyle(Color("stage1Brown"))
                                            .annotation {
                                                Text(String(format: "%.2f%%", (Double(self.succeedTimes) / Double(self.failTimes + self.succeedTimes)) * 100))
                                            }
                                        
                                        BarMark(
                                            x: .value("Index", "fail times"),
                                            y: .value("Value", failTimes)
                                        ).foregroundStyle(Color("stage1Brown"))
                                            .annotation {
                                                Text(String(format: "%.2f%%", (Double(self.failTimes) / Double(self.failTimes + self.succeedTimes)) * 100))
                                            }
                                    }
                                    .frame(height: 250)
                                }
                            }
                            VStack{
                                Text("You performed a total of \(self.succeedTimes+self.failTimes) actual actions, of which you succeeded \(self.succeedTimes) times and failed \(self.failTimes) times.\nStop was selected \(self.stopTimes) times, indicate that you make money in \( String(format: "%.2f%%", (Double(self.stopTimes))*100/20.0 )) of all 20 rounds.")
                                    .font(.custom("Courier", size: 30))
                                    .padding()
                            }
                        }
                    }else{
                        Text("😢Please update ios16 to see the specific report")
                    }
                }.padding()
            }.tag(2)
            
            VStack{
                ScrollView{
                if #available(iOS 16.0, *) {
                    VStack{
                        Spacer()
                        HStack{
                            GroupBox ( "MacSafe ") {
                                Chart{
                                    BarMark(
                                        x: .value("Index", "success times"),
                                        y: .value("Value", opt1SucceedTimes)
                                    ).foregroundStyle(Color("stage1Brown"))
                                        .annotation {
                                            Text(String(format: "%.2f%%", (Double(self.opt1SucceedTimes) / Double(self.opt1FailTimes + self.opt1SucceedTimes)) * 100))
                                        }
                                    
                                    BarMark(
                                        x: .value("Index", "fail times"),
                                        y: .value("Value", opt1FailTimes)
                                    ).foregroundStyle(Color("stage1Brown"))
                                        .annotation {
                                            Text(String(format: "%.2f%%", (Double(self.opt1FailTimes) / Double(self.opt1FailTimes + self.opt1SucceedTimes)) * 100))
                                            
                                        }
                                }
                                .frame(height: 250)
                            }
                            
                            
                            GroupBox ( "iRisks ") {
                                Chart{
                                    BarMark(
                                        x: .value("Index", "success times"),
                                        y: .value("Value", opt2SucceedTimes)
                                    )
                                    .foregroundStyle(Color("stage1Green"))
                                    .annotation {
                                        Text(String(format: "%.2f%%", (Double(self.opt2SucceedTimes) / Double(self.opt2FailTimes + self.opt2SucceedTimes)) * 100))
                                    }
                                    
                                    BarMark(
                                        x: .value("Index", "fail times"),
                                        y: .value("Value", opt2FailTimes)
                                    ).foregroundStyle(Color("stage1Green"))
                                        .annotation {
                                            Text(String(format: "%.2f%%", (Double(self.opt2FailTimes) / Double(self.opt2FailTimes + self.opt2SucceedTimes)) * 100))
                                        }
                                }
                                .frame(height: 250)
                            }
                        }
                        
                        Text("Your MacSafe to iRisks selection ratio is \(self.opt1FailTimes + self.opt1SucceedTimes) : \(self.opt2FailTimes + self.opt2SucceedTimes), indicating that you are a")
                            .font(.custom("Courier", size: 30))
                        HStack{
                            Text("\(self.riskTendency)")
                                .font(.custom("Courier", size: 35))
                                .bold()
                            Button(action: {
                                showPopover3.toggle()
                            }) {
                                Image(systemName: "questionmark.circle")
                                    .font(.title)
                            }.popover(isPresented: $showPopover3) {
                                VStack(alignment: .leading) {
                                    Text("Detailed Explanation")
                                        .font(.title)
                                        .bold()
                                    Text(detailedExplain3)
                                        .font(.title2)
                                        .padding(.top)
                                }
                                .padding()
                                .frame(width: 500, height: 400)
                                //.background(.white)

                            }
                        }
                        
                    }
                    
                } else {
                    // Fallback on earlier versions
                    Text("😢Please update ios16 to see the specific report")
                }
                }.padding()

            }.tag(3)
            
        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .onAppear {
                let reportText = generateReportText(elapsedTime: elapsedTime, succeedTimes: succeedTimes, failTimes: failTimes, opt1SucceedTimes: opt1SucceedTimes, opt1FailTimes: opt1FailTimes, opt2SucceedTimes: opt2SucceedTimes, opt2FailTimes: opt2FailTimes, stopTimes: stopTimes, overallIncome: overallIncome)
                riskTendency = reportText.riskTendency
                decisiveness = reportText.decisiveness
                incomeEvaluation = reportText.incomeEvaluation
            }
            //.background(.white)
    }
}

struct Stage1GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        Stage1GameOverView(
            
            elapsedTime: 12.3,
            succeedTimes: 35,
            failTimes: 12,
            opt1SucceedTimes: 24,
            opt1FailTimes: 4,
            opt2SucceedTimes: 11,
            opt2FailTimes: 8,
            stopTimes: 8,
            overallIncome: 2900,
            eachRoundsLastArray: [3,1,10,0,5,2,3,6,8,3,3,1,10,0,5,2,3,6,8,3],
            incomeArray:[300,0,100,0,500,200,300,600,800,300,300,100,100,0,500,200,300,600,800,300]
        )
    }
}
