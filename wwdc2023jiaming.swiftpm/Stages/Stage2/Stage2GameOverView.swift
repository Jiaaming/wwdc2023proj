//
//  File.swift
//
//
//  Created by 刘佳铭 on 2023/3/25.
//
import SwiftUI

import Charts
let cong2 = """
As the CEO, you made some tough decisions and led Apple through 20 exhilarating rounds. Let's take a look at how you fared!
"""

struct Stage2GameOverView: View {
    let elapsedTime: TimeInterval
    let attemptedOffers: [Int]
    let successfulHires: [Int]
    let failedHires: [Int]
    let allCardScoreShow: [Int]
//    init(elapsedTime: TimeInterval, attemptedOffers: [Int], successfulHires: [Int], failedHires: [Int]) {
//        self.elapsedTime = elapsedTime
//        self.attemptedOffers = attemptedOffers
//        self.successfulHires = successfulHires.sorted()
//        self.failedHires = failedHires.sorted()
//    }
    var successRate: Double {
        Double(successfulHires.count) / Double(attemptedOffers.count)
    }
    
    var averageiScore: Double {
        successfulHires.isEmpty ? 0 : Double(successfulHires.reduce(0, +)) / Double(8)
    }
    var averageAlliScore: Double {
        allCardScoreShow.isEmpty ? 0 : Double(allCardScoreShow.reduce(0, +)) / Double(allCardScoreShow.count)
    }
    var averageAttemptediScore: Double {
        attemptedOffers.isEmpty ? 0 : Double(attemptedOffers.reduce(0, +)) / Double(attemptedOffers.count)
    }
    
    @State private var successRateRating: String = ""
    @State private var averageiScoreRating: String = ""
    @State private var decisionSpeedRating: String = ""
    @State private var categoryBreakdown: String = ""
    
    @State private var showPopover1 = false
    @State private var showPopover2 = false
    @State private var showPopover3 = false
    
    @State private var selectedTab = 0
    
    func evaluateUserPerformance(
        attemptedOffers: [Int],
        successfulHires: [Int],
        failedHires: [Int],
        elapsedTime: TimeInterval,
        successRate: Double,
        averageiScore: Double,
        averageAttemptediScore: Double
    ) -> (successRateRating: String, averageiScoreRating: String, decisionSpeedRating: String, categoryBreakdown: String) {
        
        var successiScoreRating: String
        var averageiScoreRating: String
        var decisionSpeedRating: String
        
        // Success Rate Rating
        if averageiScore >= 55 {
            successiScoreRating = "Master Recruiter"
        } else if averageiScore >= 45 {
            successiScoreRating = "Expert Talent Scout"
        } else {
            successiScoreRating = "Aspiring Headhunter"
        }
        
        // Average iScore Rating
        if averageAttemptediScore >= 55 {
            averageiScoreRating = "Bold Visionary"
        } else if averageAttemptediScore >= 45 {
            averageiScoreRating = "Balanced Talent Spotter"
        } else {
            averageiScoreRating = "Risk-Averse Recruiter"
        }
        
        // Decision Speed Rating
        if elapsedTime <= 60 {
            decisionSpeedRating = "Lightning-fast Decider"
        } else if elapsedTime <= 90 {
            decisionSpeedRating = "Balanced Evaluator"
        } else {
            decisionSpeedRating = "Thoughtful Analyst"
        }
        
        // Category Breakdown
        let topTierCount = successfulHires.filter { $0 >= 66 }.count
        let midTierCount = successfulHires.filter { $0 >= 33 && $0 < 66 }.count
        let entryLevelCount = successfulHires.filter { $0 < 33 }.count
        let categoryBreakdown = "Top-tier talents: \(topTierCount), Mid-tier talents: \(midTierCount), Entry-level talents: \(entryLevelCount)"
        
        return (successiScoreRating, averageiScoreRating, decisionSpeedRating, categoryBreakdown)
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            VStack {
                ScrollView{
                    Spacer()
                    HStack{
                        Image("stage2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                        Text("🎉 Congratulations on completing your recruitment for Apple!\" ")
                            .font(.custom("Avenir", size: 50)
                                .weight(.bold))
                            .foregroundColor(Color("stage2Blue"))
                            .padding(10)
                    }
                    Divider()
                        .padding(20)
                    
                    Text(cong)
                        .font(.custom("Courier", size: 30))
                    //.foregroundColor(Color("stage1Pink"))
                        .padding(20)
                }.padding()
                
            }.tag(0)
            
            
            VStack{
                ScrollView{
                    if #available(iOS 16.0, *) {
                        Spacer()
                        VStack{
                            
                                GroupBox ( "🙌iScore of All people you viewed") {
                                    ScrollView(.horizontal){
                                        Chart {
                                            ForEach(allCardScoreShow.indices, id: \.self) { index in
                                                BarMark(
                                                    x: .value("Index", "\(index + 1)"),
                                                    y: .value("Value", allCardScoreShow[index])
                                                )
                                            }
                                        }
                                        .foregroundColor(Color("stage2Pink"))
                                        .frame(width: 1600, height: 300)
                                            
                                    }
                                    
                                }
                            
                            
                            
                            VStack{
                                Text("You have viewed a total of \(allCardScoreShow.count) applicants and their total average iScore is \(String(format: "%.2f",averageAlliScore))\n")
                                    .font(.custom("Courier", size: 30))
                       
                                
                                
                            }.padding()
                            
                            
                            
                        }
                    }else{
                        Text("😢Please update ios16 to see the specific report")
                    }
                    
                }.padding()
            }.tag(1)
            
            VStack{
                ScrollView{
                    if #available(iOS 16.0, *) {
                        Spacer()
                        VStack{
                            GroupBox ( "iScore of Candidates you Try to connect") {
                                Chart {
                                    ForEach(attemptedOffers.indices, id: \.self) { index in
                                        LineMark(
                                            x: .value("Index", "\(index + 1)"),
                                            y: .value("Value", attemptedOffers[index])
                                        )
                                    }
                                }
                                .foregroundColor(Color("stage2Blue"))
                                .frame(height: 250)
                            }
                            
                            
                        }
                        Text("You spend ⏱ \( String(format: "%.2f", elapsedTime)) seconds with \(String(format: "%.2f", successRate*100)) % Contract success rate!！\n\n Your average candidate iScore for sending offers is \(String(format: "%.2f", averageAttemptediScore)) Based on your performance, we'd say you're a")
                            .font(.custom("Courier", size: 30))
                            .padding()
                        HStack{
                            Text(averageiScoreRating).bold()
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
                                    Text(detailedExplain11)
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
                            Text(decisionSpeedRating).bold()
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
                                    Text(detailedExplain22)
                                        .font(.title2)
                                        .padding(.top)
                                }
                                .padding()
                                .frame(width: 500, height: 400)
                                //.background(.white)

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
                            GroupBox ( "📋 iScore of successful Hires") {
                                Chart {
                                    ForEach(successfulHires.indices, id: \.self) { index in
                                        BarMark(
                                            x: .value("Index", "\(index + 1)"),
                                            y: .value("Value", successfulHires[index])
                                        ).annotation {
                                            Text(String(successfulHires[index]))
                                        }
                                    }
                                }
                                .foregroundColor(Color("stage2Blue2"))
                                .frame(height: 250)
                            }
                            Text("Among all the people you hired, \(categoryBreakdown)")
                                .font(.custom("Courier", size: 30))
                            VStack{
                                Text("The average iScore of the people you have selected is \(String(format: "%.2f",Double(successfulHires.reduce(0, +)) / Double(8))).")
                                    .font(.custom("Courier", size: 30))
                                Text("Wow! You are a")
                                    .font(.custom("Courier", size: 30))
                                HStack{
                                    Text(successRateRating).bold()
                                        .font(.custom("Courier", size: 36))
                                    
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
                                            Text(detailedExplain33)
                                                .font(.title2)
                                                .padding(.top)
                                        }
                                        .padding()
                                        .frame(width: 500, height: 400)
                                        //.background(.white)

                                    }
                                }
                                
                            }.padding()
                            
                            
                            
                        }
                    }else{
                        Text("😢Please update ios16 to see the specific report")
                    }
                }.padding()
            }.tag(3)
            
            VStack{
                ScrollView{
                    if #available(iOS 16.0, *) {
                        VStack{
                            Spacer()
                            HStack{
                                Image("bg1")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 200)
                                Text("🎉 Congratulations on completing the entire game! ")
                                    .font(.custom("Avenir", size: 50)
                                        .weight(.bold))
                                    .foregroundColor(Color("stage2Blue"))
                                    .padding(10)
                            }
                            Divider()
                                .padding(20)
                            
                            Text("We live in a world full of randomness and uncertainty. With these two simple simulations of real business decision making process, I hope it will give you some experience and thoughts on risk management.")
                                .font(.custom("Courier", size: 30))
                            //.foregroundColor(Color("stage1Pink"))
                                .padding(20)
                            
                            
                            
                        }.tag(4)
                        
                    } else {
                        // Fallback on earlier versions
                        Text("😢Please update ios16 to see the specific report")
                    }
                }.padding()
            }.tag(4)
        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .onAppear {
                let reportText = evaluateUserPerformance(attemptedOffers : attemptedOffers,  successfulHires:  successfulHires, failedHires: failedHires, elapsedTime: elapsedTime,successRate:successRate, averageiScore: averageiScore,averageAttemptediScore: averageAttemptediScore)
                successRateRating = reportText.successRateRating
                averageiScoreRating = reportText.averageiScoreRating
                decisionSpeedRating = reportText.decisionSpeedRating
                categoryBreakdown = reportText.categoryBreakdown
            }
            //.background(.white)

    }
}

struct Stage2GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        Stage2GameOverView(
            elapsedTime: 30.0,
            attemptedOffers: [24,12,53,64,12,6,76,34,12,65,23,54,76,12,45],
            successfulHires: [50, 50, 50, 50, 50, 50], failedHires: [24,12,53,64,54,76,12,45],
            allCardScoreShow: [24,12,53,64,12,6,76,34,12,65,23,54,76,12,45, 12,6,76,34,12,65,23,12,6,76,34,12,65,23, 24,12,53,64,12,6,76,34,12,65,23,54,76,12,45, 12,6,76,34,12,65,23,12,6,76,34,12,65,23,24,12,53,64,12,6,76,34,12,65,23,54,76,12,45, 12,6,76,34,12,65,23,12,6,76,34,12,65,23,24,12,53,64,12,6,76,34,12,65,23,54]
            
        )
    }
}
