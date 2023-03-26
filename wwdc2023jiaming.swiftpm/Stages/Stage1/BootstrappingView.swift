import SwiftUI

struct BootstrappingView: View {
    @State private var balloonSize: CGFloat = 100
    @State private var currentMoney: Int = 0
    @State private var overallIncome: Int = 0
    @State private var P1: Double = 0.10
    @State private var P2: Double = 0.30

    @State private var balloonColor: Color = .red
    @State private var currentTurn: Int = 0
    private let totalTurns: Int = 20
    @State private var emoji: String = "🙌"
    @State private var isGameOver: Bool = false
    
    let stageCompleted: () -> Void
    
    func nicheAction(){
        balloonSize += 25
        currentMoney += 50
        let randomValue = Double.random(in: 0...1)
        if randomValue <= P1 {
            balloonSize = 100
            currentMoney = 0
            currentTurn += 1
            emoji = failEmoji.randomElement()!
        } else {
            balloonColor = Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
            emoji = succeedEmoji.randomElement()!
        }
    }
    
    func suppliersAction(){
        balloonSize += 75
        currentMoney += 200
        
        let randomValue = Double.random(in: 0...1)
        if randomValue <= P2 {
            balloonSize = 100
            currentMoney = 0
            overallIncome -= 100
            currentTurn += 1
            emoji = failEmoji.randomElement()!
        } else {
            balloonColor = Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
            emoji = succeedEmoji.randomElement()!
        }
        
    }
    
    func stopAction(){
        emoji = resetEmoji
        overallIncome += currentMoney
        currentMoney = 0
        currentTurn+=1
        balloonSize = 100
    }
    
    var body: some View {
        TabView {
            BootstrappingIntro()
                .tabItem {
                    Image(systemName: "scroll")
                    Text("Stage1 Intro")
                }
            
            
            
            VStack {
                ProgressView(value: Float(currentTurn), total: Float(totalTurns))
                                .padding(.horizontal, 50)
                Spacer()
                
                ZStack(alignment: .center){
                    Circle()
                        .fill(balloonColor)
                        .frame(width: balloonSize, height: balloonSize)
                        .animation(.interpolatingSpring(stiffness: 30, damping: 7))
                    
                    Text(emoji)
                        .font(.system(size: balloonSize*0.5))
                        .frame(width: balloonSize, height: balloonSize)
                        .animation(.interpolatingSpring(stiffness: 30, damping: 7))
                    
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
                        Button(action: {
                            nicheAction()
                        }) {
                            Text("Find Niche")
                                .padding()
                        }
                        .background(Capsule()
                            .stroke(gradient, lineWidth: 2)
                            .saturation(1.8))
                        .padding(20)
                        Button(action: {
                            suppliersAction()
                        }) {
                            Text("Find suppliers")
                                .padding()
                        }
                        .background(Capsule()
                            .stroke(gradient, lineWidth: 2)
                            .saturation(1.8))
                        
                        
                    }
                    
                    
                    Button(action: {
                        stopAction()
                    }) {
                        Text("Stop")
                            .padding()
                    }
                    .background(Capsule()
                        .stroke(gradient, lineWidth: 2)
                        .saturation(1.8))
                    
                    
                    Button("See my Report"){
                        self.isGameOver.toggle()
                    }
                        .sheet(isPresented: $isGameOver) {
                            Stage1GameOverView()
                                .frame(width: 300, height: 500) // Set the desired width and height here
                        }
                        

                        .font(.custom("Courier", size: 25))
                        .foregroundColor(.black)
                }
                
                
                Spacer()
            
            }
                .tabItem {
                    Image(systemName: "network")
                    Text("Stage1 Game")
                }
        }
        
    }
}

//struct BootstrappingView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
