//
//  File.swift
//  
//
//  Created by 刘佳铭 on 2023/3/23.
//

import Foundation
import SwiftUI
struct ShortIntroductionView: View {
    var body: some View {
        NavigationView {
            VStack {
                VStack() {
                    NavigationLink(destination: StartPageView()) {
                        Text("点击跳转")
                    }
                }
            }
            .navigationBarTitle("Introduction", displayMode: .automatic)

        }
        
    }
}
