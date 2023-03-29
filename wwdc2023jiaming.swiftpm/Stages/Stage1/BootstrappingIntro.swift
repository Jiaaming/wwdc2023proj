//
//  File.swift
//  
//
//  Created by 刘佳铭 on 2023/3/24.
//

import Foundation
import SwiftUI

struct BootstrappingIntro: View {
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)

    var body: some View {
        ScrollView {
            
            
            VStack(alignment: .leading, spacing: 10) {
                HStack{
                    Image("stage1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)

                    Text(welcome)
                        .font(.custom("Avenir", size: 70)
                            .weight(.bold))
                        .foregroundColor(Color("stage1Brown"))

                }
                Divider()
                .padding(20)
                Text(IntroDescription)
                    .font(.custom("Courier", size: 30))
                    .foregroundColor(Color("stage1Pink"))
                
                Divider()
                .padding(20)
                
                Text("What you need to Do?")
                    .font(.custom("Courier", size: 50)
                        .weight(.bold))
                    .foregroundColor(Color("stage1Green"))
                
                          
                Text(choicesDescription)
                
                LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(0..<12) { index in
                                    let row = index / 4
                                    let column = index % 4
                                    Text(introArr[row][column])
                                        .fontWeight(row == 0 ? .bold : .regular)
                                        
                                }
                            }
                            .padding()
                
                Divider()

                Text("Risks")
                    .font(.title)
                    .foregroundColor(.pink)
                Text(riskDescription)
                    .foregroundColor(Color("stage1Pink"))

                

            }
            .padding()
        }
        .background(Color.white)
                .edgesIgnoringSafeArea(.all)
    }
}

struct BootstrappingIntro_Previews: PreviewProvider {
    static var previews: some View {
        BootstrappingIntro()
    }
}
