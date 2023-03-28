//
//  File.swift
//  
//
//  Created by 刘佳铭 on 2023/3/25.
//
import SwiftUI

import Charts
struct Stage1GameOverView: View {
    let elapsedTime: TimeInterval
    let succeedTimes: Int
    let failTimes: Int
    let opt1SucceedTimes: Int
    let opt1FailTimes: Int
    let opt2SucceedTimes: Int
    let opt2FailTimes: Int
    let stopTimes: Int
    
    let eachRoundsLastArray: [Int]
    //    var intArray: [Int] {
    //        eachRoundsLastArray.map { $0.successCount }
    //    }
    var body: some View {
        ScrollView{
            VStack {
                Text("Game Over")
                    .font(.largeTitle)
                
                Text("Elapsed Time: \(elapsedTime, specifier: "%.2f") seconds")
                    .font(.title)
                
                
                if #available(iOS 16.0, *) {
                    VStack{
                        GroupBox ( "Successful Actions per Round") {
                            Chart {
                                ForEach(eachRoundsLastArray.indices, id: \.self) { index in
                                    LineMark(
                                        x: .value("Index", "\(index + 1)"),
                                        y: .value("Value", eachRoundsLastArray[index])
                                    )
                                    
                                }
                            }.frame(height: 250)
                            
                        }
                        HStack{
                            GroupBox ( "Find-Stop ratio") {
                                Chart{
                                    BarMark(
                                        x: .value("Index", "Find times"),
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
                        
                        HStack{
                            GroupBox ( "Find Niche ") {
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
                            
                            
                            GroupBox ( "Find Suppliers ") {
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
                        
                        
                        
                        
                        
                    }
                    
                    
                    
                } else {
                    // Fallback on earlier versions
                    Text("😢Please update ios16 to see the specific report")
                }
            }
            
        }
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

            eachRoundsLastArray: [3,1,10,0,5,2,3,6,8,3,3,1,10,0,5,2,3,6,8,3]
        )
    }
}
