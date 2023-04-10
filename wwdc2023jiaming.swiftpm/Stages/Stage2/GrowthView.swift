import SwiftUI
import GameplayKit

struct GrowthView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State private var restartView = false
    
    let numberOfSelectedCards: Int = 8
    @State private var cards = [(Int, String)](repeating: (0, ""), count: 3)
    @State private var selectedCards: [(Int, String)]
    
    init() {
        _selectedCards = State(initialValue: [(Int, String)](repeating: (0, ""), count: numberOfSelectedCards))
    }
    @State private var failTimes: Int = 0
    @State private var succeedTimes: Int = 0
    
    @State private var scaleFactor: CGFloat = 1.0
    
    @State private var selectedIndex = -1
    @State private var selectionConfirmed = false
    @State private var totalValue = 0
    @State private var selectionResult: String? = nil
    @State private var currentTurn: Int = 0 {
        didSet {
            if checkIfEnd() {
                
                let endTime = Date()
                elapsedTime = endTime.timeIntervalSince(startTime!)
                // Reset the state
                startTime = nil
            }
        }
    }
    @State private var totalTurns: Int = 16
    @State private var tapsRemaining: Int = 8
    @State private var selectNum: Int = 0
    
    @State private var isGameOver: Bool = false
    @State private var showDoc: Bool = false
    @State private var showingAlert = false
    
    @State private var tryArray = [Int]()
    @State private var successArray = [Int]()
    @State private var failArray = [Int]()
    @State private var elapsedTime: Double? = 0.0
    @State private var startTime: Date? = nil
    func startCountTime(){
        if startTime == nil {
            startTime = Date()
        }
    }
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
    
    func checkIfEnd() -> Bool{
        return (currentTurn == totalTurns || selectNum == numberOfSelectedCards)
    }
    private func selectCard(at index: Int) {
        startCountTime()

        selectedIndex = index
        selectionConfirmed = true
    }
    
    private func confirmSelection() {
        startCountTime()
        currentTurn += 1;
        if selectionConfirmed {
            for i in 0..<selectedCards.count {
                if selectedCards[i].0 == 0 {
                    let successProbability = 100 -  cards[selectedIndex].0
                    if Int.random(in: 1...100) <= successProbability {
                        selectedCards[i] = cards[selectedIndex]
                        totalValue += selectedCards[i].0
                        successArray.append(selectedCards[i].0)
                        
                        selectionResult = "Success!"
                        selectNum += 1
                        succeedTimes += 1
                    } else {
                        failArray.append(selectedCards[i].0)
                        
                        selectionResult = "Fail"
                        failTimes += 1
                    }
                    tryArray.append(selectedCards[i].0)
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
            
            
            
            if let result = selectionResult {
                Text(result)
                    .font(.title)
                    .foregroundColor(result == "Success!" ? .green : .red)
                    .padding(.bottom, 10)
                    .frame(width: 150,height: 50)
                    .scaleEffect(scaleFactor)
                    .animation(.easeInOut(duration: 0.5), value: scaleFactor)
                
            }else{
                Text("🧐")
                    .font(.title)
                    .padding(.top, 10)
                
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
            Spacer()
            
            if(!checkIfEnd()){
                
                
                Button(action: {
                    startCountTime()
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
                .confettiCannon(counter: $succeedTimes, confettis: [.text("✅")], confettiSize: 20)
                .confettiCannon(counter: $failTimes, confettis: [.text("❌")], confettiSize: 20)
                Spacer()
                
                Button(action: {
                    startCountTime()

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
            }
            if(checkIfEnd()){
                VStack{
                    Text("🎆 Congratulations! You have finished")
                        .font(.custom("Avenir", size: 50))
                        .foregroundColor(Color("stage2Blue"))
                        .padding(10)
                    Button(action: {
                        // Handle button tap
                        isGameOver.toggle()
                        
                    }) {
                        
                        Text("📄 See my Report")
                        //String(describing: elapsedTime)
                    }
                    .buttonStyle(GrowingButton(isDisabled: false, color: Color("stage2Pink")))
                    .font(.largeTitle)
                    .padding(10)
                    
                    Button(action: {
                        restartView.toggle()
                    }) {
                        Text("🔄 Restart game")
                        
                    }
                    .buttonStyle(GrowingButton(isDisabled: false, color: Color("stage2Blue")))
                    .padding(10)
                }
            }
            Spacer()
            
            HStack {
                ForEach(0..<selectedCards.count) { index in
                    CardView(value: selectedCards[index].0, isSelected: false, emoji: selectedCards[index].1,                         width: 100, height: 150)
                }
            }
            Spacer()
        }
        .sheet(isPresented: $showDoc) {
            Stage2MenuView()
        }
        .sheet(isPresented: $isGameOver) {
            Stage2GameOverView(
                elapsedTime: self.elapsedTime ?? 0.0,
                attemptedOffers : tryArray,
                successfulHires: successArray,
                failedHires: failArray)
        }
        .background(Color.white)
        .onAppear {
            self.showDoc = true
        }
        
        .onAppear {
            generateRandomCards()
        }
        .id(restartView)
        
    }
}

struct GrowthView_Previews: PreviewProvider {
    static var previews: some View {
        GrowthView()
    }
}
