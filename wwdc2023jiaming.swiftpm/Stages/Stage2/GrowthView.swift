import SwiftUI
import GameplayKit

struct GrowthView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    let numberOfSelectedCards: Int = 8
    @State private var cards = [(Int, String)](repeating: (0, ""), count: 3)
    @State private var selectedCards: [(Int, String)]
    
    init() {
        _selectedCards = State(initialValue: [(Int, String)](repeating: (0, ""), count: numberOfSelectedCards))
    }
    @State private var selectedIndex = 0
    @State private var selectionConfirmed = false
    @State private var totalValue = 0
    @State private var selectionResult: String? = nil
    @State private var currentTurn: Int = 0
    @State private var totalTurns: Int = 15
    @State private var tapsRemaining: Int = 8
    @State private var selectNum: Int = 0
    
    @State private var isGameOver: Bool = false
    @State private var showDoc: Bool = false
    @State private var showingAlert = false
    
    private func generateRandomCards() {
        let interval1 = 1
        let interval2 = 100
        let mean = (interval1 + interval2) / 3
        let standardDeviation = (interval2 - interval1) / 4
        
        let randomSource = GKRandomSource.sharedRandom()
        let gaussianDistribution = GKGaussianDistribution(randomSource: randomSource, mean: Float(mean), deviation: Float(standardDeviation))
        
        for i in 0..<3 {
            let randomNumber = gaussianDistribution.nextInt()
            let clampedRandomNumber = max(interval1, min(interval2, randomNumber))
            cards[i] = (clampedRandomNumber, emojis.randomElement()!)
        }
    }
    
    
    private func selectCard(at index: Int) {
        selectedIndex = index
        selectionConfirmed = true
    }
    
    private func confirmSelection() {
        currentTurn += 1;
        if selectionConfirmed {
            for i in 0..<selectedCards.count {
                if selectedCards[i].0 == 0 {
                    let successProbability = 100 -  cards[selectedIndex].0
                    if Int.random(in: 1...100) <= successProbability {
                        selectedCards[i] = cards[selectedIndex]
                        totalValue += selectedCards[i].0
                        selectionResult = "Success!"
                        selectNum += 1
                    } else {
                        selectionResult = "Fail"
                    }
                    break
                }
            }
        }
        generateRandomCards()
        selectionConfirmed = false
        selectedIndex = -1
    }
    
    
    var body: some View {
        VStack {
            VStack{
                HStack{
                    Button(action: {
                        // Handle left-top button tap
                        showingAlert = true
                    }) {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding()
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Are you sure?"),
                            message: Text("You will lose the current progress."),
                            primaryButton: .destructive(Text("Confirm")) {
                                presentationMode.wrappedValue.dismiss()
                            },
                            secondaryButton: .cancel()
                        )
                    }
                    Spacer()
                    Text("You still have: \(totalTurns - currentTurn) sending times. You left \(numberOfSelectedCards - selectNum) jobs!")
                    Spacer()
                    Button(action: {
                        // Handle button tap
                        showDoc.toggle()
                    }) {
                        Image(systemName: "doc.text")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding()
                    }
                }
                .padding(.horizontal)
                
                ProgressView(value: Float(currentTurn), total: Float(totalTurns))
                    .padding(EdgeInsets(top: 10, leading: 15, bottom: 5, trailing: 15))
            }
            
            Spacer()
            
            
            if let result = selectionResult {
                Text(result)
                    .font(.title)
                    .foregroundColor(result == "Success!" ? .green : .red)
                    .padding(.bottom, 10)
                    .frame(width: 150,height: 50)
            }else{
                Text("🧐")
                    .font(.largeTitle)
                    .padding(.bottom, 10)
                    .frame(width: 150,height: 50)
            }
            HStack {
                ForEach(0..<3) { index in
                    CardView(value: cards[index].0, isSelected: selectedIndex == index, emoji: cards[index].1, width: 300, height: 450)
                        .onTapGesture {
                            selectCard(at: index)
                        }
                        .padding(3)
                }
            }
            .padding(.top, 50)
            
            
            Button(action: {
                if currentTurn<totalTurns {
                    confirmSelection()
                }
                
                
            }) {
                Text((totalTurns - currentTurn) > 0 ? "Send Offer! ⚠️ \(totalTurns - currentTurn) times left" : "Oops! You have no chance to send offer")
                    .font(.title)
                    .padding(10)
            }
            .buttonStyle(GrowingButton(isDisabled: currentTurn == totalTurns, color:Color("stage2Blue")))
            .disabled(!selectionConfirmed)
            .padding(.top, 20)
            
            Button(action: {
                if tapsRemaining > 0 {
                    generateRandomCards()
                    tapsRemaining -= 1
                }
            }) {
                Text(tapsRemaining > 0 ? "Switch another group:⚠️ \(tapsRemaining) times left" : "Oops! You have no chance to switch")
                    .font(.title)

                    .padding(10)
                
                
            }
            .disabled(tapsRemaining <= 0)
            .buttonStyle(GrowingButton(isDisabled: tapsRemaining == 0, color:Color("stage2Pink")))
            .padding(.top, 10)
            Spacer()
            
            Text("Total Value: \(totalValue)")
                .padding(.top, 20)
            HStack {
                ForEach(0..<selectedCards.count) { index in
                    CardView(value: selectedCards[index].0, isSelected: false, emoji: selectedCards[index].1, width: 100, height: 150)
                }
            }
            
            
            

            
            
            Spacer()
        }
        .sheet(isPresented: $showDoc) {
            Stage2MenuView()
        }
        .onAppear {
            self.showDoc = true
        }
        
        .onAppear {
            generateRandomCards()
        }
    }
}

struct GrowthView_Previews: PreviewProvider {
    static var previews: some View {
        GrowthView()
    }
}
