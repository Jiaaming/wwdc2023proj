import SwiftUI

struct GrowthView: View {
    @State private var cards = [(Int, String)](repeating: (0, ""), count: 3)
    @State private var selectedCards = [(Int, String)](repeating: (0, ""), count: 5)
    @State private var selectedIndex = 0
    @State private var selectionConfirmed = false
    @State private var totalValue = 0
    @State private var selectionResult: String? = nil
    
    private func generateRandomCards() {
        for i in 0..<3 {
            cards[i] = (Int.random(in: 5...15), emojis.randomElement()!)
        }
    }
    
    private func selectCard(at index: Int) {
        selectedIndex = index
        selectionConfirmed = true
    }
    
    private func confirmSelection() {
        if selectionConfirmed {
            for i in 0..<selectedCards.count {
                if selectedCards[i].0 == 0 {
                    let successProbability = 100 - 2 * cards[selectedIndex].0
                    if Int.random(in: 1...100) <= successProbability {
                        selectedCards[i] = cards[selectedIndex]
                        totalValue += selectedCards[i].0
                        selectionResult = "Success!"
                    } else {
                        selectionResult = "Fail"
                    }
                    break
                }
            }
        }
        generateRandomCards()
        selectionConfirmed = false
    }
    
     
    var body: some View {
        VStack {
            if let result = selectionResult {
                Text(result)
                    .font(.title)
                    .foregroundColor(result == "Success!" ? .green : .red)
                    .padding(.bottom, 10)
            }
            HStack {
                ForEach(0..<3) { index in
                    CardView(value: cards[index].0, isSelected: selectedIndex == index, emoji: cards[index].1, width: 300, height: 450)
                        .onTapGesture {
                            selectCard(at: index)
                        }
                    
                }
            }
            .padding(.top, 50)
            
            Button(action: confirmSelection) {
                Text("Confirm Selection")
            }
            .disabled(!selectionConfirmed)
            .padding(.top, 20)
            
            HStack {
                ForEach(0..<selectedCards.count) { index in
                    CardView(value: selectedCards[index].0, isSelected: false, emoji: selectedCards[index].1, width: 150, height: 225)
                }
            }
            .padding(.top, 20)
            
            Button(action: generateRandomCards) {
                Text("Recreate Cards")
            }
            .padding(.top, 20)
            
            Text("Total Value: \(totalValue)")
                .padding(.top, 20)
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
