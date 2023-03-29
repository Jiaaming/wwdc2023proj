import SwiftUI



struct BootstrappingView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var balloonSize: CGFloat = 100
    @State private var currentMoney: Int = 0
    @State private var overallIncome: Int = 0
    private var P1: Double = 0.10
    private var P2: Double = 0.30
    @State private var showingAlert = false
    
    @State private var failTimes: Int = 0
    @State private var succeedTimes: Int = 0
    @State private var opt1FailTimes: Int = 0
    @State private var opt1SucceedTimes: Int = 0
    @State private var opt2FailTimes: Int = 0
    @State private var opt2SucceedTimes: Int = 0
    @State private var stopTimes: Int = 0
    //@State private var eachRoundsLastArray: [Int]
    
    
    @State private var balloonColor: Color = .red
    @State private var startTime: Date? = nil
    @State private var elapsedTime: Double? = 0.0
    @State private var currentTurn: Int = 0 {
        didSet {
            if currentTurn == totalTurns {
                
                let endTime = Date()
                elapsedTime = endTime.timeIntervalSince(startTime!)
                
                // Reset the state
                startTime = nil
            }
        }
    }
    private let totalTurns: Int = 20
    @State private var emoji: String = "🙌"
    @State private var isGameOver: Bool = false
    @State private var showDoc: Bool = false
    @State var counter:Int = 2
    
    
    @State private var roundsData: [RoundData] = Array(repeating: RoundData(), count: 20)
    @State private var currentRound: Int = 0
    
    
    func startCountTime(){
        if startTime == nil {
            startTime = Date()
        }
    }
    func nicheAction(){
        startCountTime()
        balloonSize += 25
        currentMoney += 50
        let randomValue = Double.random(in: 0...1)
        let fail = randomValue <= P1
        if fail { // fail
            balloonSize = 100
            currentMoney = 0
            currentTurn += 1
            emoji = failEmoji.randomElement()!
            opt1FailTimes += 1
            failTimes += 1
        } else {
            balloonColor = Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
            emoji = succeedEmoji.randomElement()!
            opt1SucceedTimes += 1
            succeedTimes += 1
        }
        
        roundsData[currentRound].updateSuccess(success: !fail)
        if fail {
            currentRound += 1
        }
        
    }
    
    func suppliersAction(){
        balloonSize += 75
        currentMoney += 200
        startCountTime()
        
        let randomValue = Double.random(in: 0...1)
        let fail = randomValue <= P2
        if fail { //fail
            balloonSize = 100
            currentMoney = 0
            overallIncome -= 100
            currentTurn += 1
            emoji = failEmoji.randomElement()!
            opt2FailTimes += 1
            failTimes += 1
        } else {
            balloonColor = Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
            emoji = succeedEmoji.randomElement()!
            opt2SucceedTimes += 1
            succeedTimes += 1
        }
        
        
        roundsData[currentRound].updateSuccess(success: !fail)
        if fail {
            currentRound += 1
        }
        
        
    }
    
    func stopAction(){
        startCountTime()
        emoji = resetEmoji
        overallIncome += currentMoney
        currentMoney = 0
        currentTurn+=1
        balloonSize = 100
        stopTimes += 1
        currentRound += 1
    }
    
    
    
    var body: some View {
        TabView {
            
            VStack {
                VStack {
                    HStack {
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
                        Text("You have done \(currentTurn)/\(totalTurns) rounds")
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
                
                ZStack(alignment: .center){
                    if currentTurn == totalTurns {
                        Text("Congrats! 🎉")
                            .font(.system(size: 50))
                            .confettiCannon(counter: $counter)
                    }
                    
                    Circle()
                        .fill(currentTurn == totalTurns ? .green : balloonColor)
                        .frame(width: currentTurn == totalTurns ? 400 : balloonSize, height: currentTurn == totalTurns ? 400 : balloonSize)
                        .animation(.interpolatingSpring(stiffness: 30, damping: 7))
                    
                    Text(currentTurn == totalTurns ? "🎉" : emoji)
                        .font(.system(size: currentTurn == totalTurns ? 100 : balloonSize * 0.5))
                    
                        .frame(width: currentTurn == totalTurns ? 400 : balloonSize, height: currentTurn == totalTurns ? 400 : balloonSize)
                        .animation(.interpolatingSpring(stiffness: 30, damping: 7))
                        .confettiCannon(counter: $succeedTimes, confettis: [.text("💵"), .text("💶"), .text("💷"), .text("💴")], confettiSize: 20)
                        .confettiCannon(counter: $failTimes, confettis: [.text("💩")], confettiSize: 20)
                    
                    
                }.frame(width: 280, height: 280)
                
                Spacer()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Current Money: $\(currentMoney)")
                        Text("Overall Income: $\(overallIncome)")
                    }
                    .padding(.leading)
                    
                    Spacer()
                }
                VStack{
                    HStack {
                        if totalTurns != currentTurn {
                            Button(action: {
                                nicheAction()
                            }) {
                                Text("Steady Orchard Growth")
                                    .padding()
                            }
                            .buttonStyle(GrowingButton(isDisabled: currentTurn == totalTurns, color:Color("stage1Brown")))
                            .disabled(currentTurn == totalTurns)
                            
                            .padding(20)
                            Button(action: {
                                suppliersAction()
                            }) {
                                Text("Operation Quantum Leap")
                                    .padding()
                            }
                            .buttonStyle(GrowingButton(isDisabled: currentTurn == totalTurns, color: Color("stage1Green")))
                            .disabled(currentTurn == totalTurns)
                        }
                        
                        
                        
                    }
                    
                    VStack{
                        if totalTurns != currentTurn {
                            Button(action: {
                                stopAction()
                                counter += 1
                            }) {
                                Text("Harvest Profits")
                                    .padding()
                                
                            }
                            .buttonStyle(GrowingButton(isDisabled: currentTurn == totalTurns, color: Color("stage1Pink")))
                            .disabled(currentTurn == totalTurns)
                        }
                        
                        
                    }.padding(10)
                    
                    if totalTurns == currentTurn {
                        Button(action: {
                            // Handle button tap
                            isGameOver.toggle()
                            
                        }) {
                            Text("See my Report")
                            //String(describing: elapsedTime)
                        }
                        .buttonStyle(GrowingButton(isDisabled: false, color: Color("stage1Green")))
                        .padding(20)
                    }
                }
                
                
                Spacer()
                
            }.sheet(isPresented: $showDoc) {
                Stage1MenuView()
            }
            .onAppear {
                self.showDoc = true
            }
            
            .sheet(isPresented: $isGameOver) {
                Stage1GameOverView(
                    elapsedTime: self.elapsedTime ?? 0.0,
                    succeedTimes: self.succeedTimes,
                    failTimes: self.failTimes,
                    opt1SucceedTimes: self.opt1SucceedTimes,
                    opt1FailTimes: self.opt1FailTimes,
                    opt2SucceedTimes: self.opt1SucceedTimes,
                    opt2FailTimes: self.opt1FailTimes,
                    stopTimes: self.stopTimes,
                    eachRoundsLastArray: self.roundsData.map { $0.successCount }
                )
            }
            .background(Color.white) 
                    
            
        }
        
            
    }
}
struct BootstrappingView_Previews: PreviewProvider {
    static var previews: some View {
        BootstrappingView()
    }
}
