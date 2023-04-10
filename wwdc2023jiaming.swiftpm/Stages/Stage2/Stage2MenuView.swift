//
//  File.swift
//  
//
//  Created by 刘佳铭 on 2023/3/29.
//

import SwiftUI

struct Stage2MenuView: View {
    @State private var selectedTab = 0
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    var body: some View {
        TabView(selection: $selectedTab) {
            VStack{
                HStack{
                    Image("stage2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    
                    Text("Welcome to \"iRecruit\": HR of Apple!")
                        .font(.custom("Avenir", size: 50)
                            .weight(.bold))
                        .foregroundColor(Color("stage2Blue"))
                        .padding(10)
                }
                Divider()
                    .padding(20)
                Text(s1)
                    .font(.custom("Courier", size: 30))
                    //.foregroundColor(Color("stage2Blue"))
                    .padding(20)
            }
            .tag(0)
        
            VStack{
                Text("Task Overview")
                    .font(.custom("Avenir", size: 50)
                        .weight(.bold))
                    .foregroundColor(Color("stage2Blue"))
                    .padding(10)
                Divider()
                    .padding(20)
                Text(s3)
                    .font(.custom("Courier", size: 30))
                    //.foregroundColor(Color("stage1Pink"))
                    .padding(20)
            }
            .tag(1)
            
            VStack{
                Text("Selection Criteria: iScore")
                    .font(.custom("Avenir", size: 50)
                        .weight(.bold))
                    .foregroundColor(Color("stage2Pink"))
                    .padding(10)
                Divider()
                    .padding(20)
                Text(s4)
                    .font(.custom("Courier", size: 30) )
                    .padding(20)
                    //.foregroundColor(Color("stage1Pink"))
                Text("With great talent comes great competition, so high iScore candidates have a lower contract success rate.")
                    .font(.custom("Courier", size: 30) .weight(.bold))
                    //.foregroundColor(Color("stage1Pink"))
                    .padding(10)
                    
            }
            .tag(2)
            
            VStack{
                Text("Risk management")
                    .font(.custom("Avenir", size: 50)
                        .weight(.bold))
                    .foregroundColor(Color("stage2Pink"))
                    .padding(10)
                Divider()
                    .padding(20)
                
                Text(s5)
                    .font(.custom("Courier", size: 30))
                    //.foregroundColor(Color("stage1Pink"))
                    .padding(20)
            }
            .tag(3)
            
            VStack{
                Text("Send off / Switch another Group")
                    .font(.custom("Avenir", size: 50)
                        .weight(.bold))
                    .foregroundColor(Color("stage2Blue"))
                    .padding(10)
                Divider()
                    .padding(20)
                Text(s6)
                    .font(.custom("Courier", size: 30))
                    //.foregroundColor(Color("stage1Pink"))
                    .padding(20)
            }
            .tag(4)
            
            VStack{
                Text("🏃Let's start!!")
                    .font(.custom("Avenir", size: 50)
                        .weight(.bold))
                    .foregroundColor(Color("stage2Blue"))
                    .padding(10)
                Divider()
                    .padding(20)
                Text(s7)
                    .font(.custom("Courier", size: 30))
                    //.foregroundColor(Color("stage1Pink"))
                    .padding(20)
            }
            .tag(5)
            
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

struct Stage2MenuView_Previews: PreviewProvider {
    static var previews: some View {
        Stage2MenuView()
    }
}

