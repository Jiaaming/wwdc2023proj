//
//  File.swift
//  
//
//  Created by 刘佳铭 on 2023/3/30.
//

import SwiftUI

class LetterViewModel: ObservableObject {
    @Published var position: CGPoint
    private var timer: Timer?
    let color: Color

    init(initialPosition: CGPoint) {
        self.position = initialPosition
        self.color = Color(red: Double.random(in: 0...1),
                                   green: Double.random(in: 0...1),
                                   blue: Double.random(in: 0...1))

        let randomInterval = Double.random(in: 0.5...2.0)
        timer = Timer.scheduledTimer(withTimeInterval: randomInterval, repeats: true) { [weak self] _ in
            let x = CGFloat.random(in: 0...UIScreen.main.bounds.width)
            let y = CGFloat.random(in: 0...UIScreen.main.bounds.height)
            
            self?.position = CGPoint(x: x, y: y)
            
        }
    }

    deinit {
        timer?.invalidate()
    }
}

struct LetterView: View {
    @ObservedObject var viewModel: LetterViewModel

    var body: some View {
        Text("")
            .font(.largeTitle)
            .position(viewModel.position)
            .foregroundColor(viewModel.color)

    }
}

func generateRandomPositions(numberOfLetters: Int) -> [CGPoint] {
    return (0..<numberOfLetters).map { _ in
        let x = CGFloat.random(in: 0...UIScreen.main.bounds.width)
        let y = CGFloat.random(in: 0...UIScreen.main.bounds.height)
        return CGPoint(x: x, y: y)
    }
}

struct BackgroundView: View {
    private let letterPositions = generateRandomPositions(numberOfLetters: 40)
    private let numberOfLetters = 40

    var body: some View {
        ZStack {
            ForEach(0..<numberOfLetters, id: \.self) { index in
                LetterView(viewModel: LetterViewModel(initialPosition: letterPositions[index]))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}

