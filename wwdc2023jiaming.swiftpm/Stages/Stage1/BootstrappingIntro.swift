//
//  File.swift
//  
//
//  Created by 刘佳铭 on 2023/3/24.
//

import Foundation
import SwiftUI

struct BootstrappingIntro: View {
    private let columns: [GridItem] = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
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
                        .foregroundColor(.brown)
                }
                
                Text(IntroDescription)
                    .font(.custom("Avenir", size: 30))
                
                Text("What you need to Do?")
                    .font(.custom("Avenir", size: 50)
                        .weight(.bold))
                    .foregroundColor(Color("stage1Green"))
                
                          
                Text(choicesDescription)
                
                LazyVGrid(columns: columns, spacing: 20) {
                    
                                    Text("Choice")
                                        .fontWeight(.bold)
                                    Text("Cost")
                                        .fontWeight(.bold)
                                    Text("Reward")
                                        .fontWeight(.bold)
                                    
                                    Text("Selecting a Niche")
                                    Text("Cost: $X")
                                    Text("Reward: $Y")
                                    
                                    Text("Finding Suppliers")
                                    Text("Cost: $X")
                                    Text("Reward: $Y")
                                    
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                
                Divider()

                Text("Risks")
                    .font(.title)
                    .foregroundColor(.pink)
                Text(riskDescription)
                Text("Choices Details")
                    .font(.title)
                

            }
            .padding()
        }
    }
}

//struct BootstrappingIntro_Previews: PreviewProvider {
//    static var previews: some View {
//        BootstrappingIntro()
//    }
//}
