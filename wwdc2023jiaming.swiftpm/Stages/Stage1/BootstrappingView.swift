import SwiftUI

struct BootstrappingView: View {
    @State private var balloonSize: CGFloat = 100
    @State private var currentMoney: Int = 0
    @State private var overallIncome: Int = 0
    @State private var explodeProbability: Double = 0.05
    @State private var balloonColor: Color = .red
    let stageCompleted: () -> Void
    
    var body: some View {
        TabView {
            BootstrappingIntro()
                .tabItem {
                    Image(systemName: "scroll")
                    Text("Stage1 Intro")
                }
            
            
            
            VStack {
                Spacer()
                
                Circle()
                    .fill(balloonColor)
                    .frame(width: balloonSize, height: balloonSize)
                    .animation(.easeInOut)
                
                Spacer()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Current Money: $\(currentMoney)")
                        Text("Overall Income: $\(overallIncome)")
                    }
                    .padding(.leading)
                    
                    Spacer()
                }
                
                HStack {
                    Button("Blow") {
                        balloonSize += 10
                        currentMoney += 50
                        let randomValue = Double.random(in: 0...1)
                        if randomValue <= explodeProbability {
                            balloonSize = 100
                            currentMoney = 0
                        } else {
                            balloonColor = Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
                        }
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Button("Stop") {
                        overallIncome += currentMoney
                        currentMoney = 0
                        balloonSize = 100
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Button("Complete Stage") {
                        stageCompleted()
                        }
                }
                .padding()
                
                VStack {
                    Text("Explode Probability: \(Int(explodeProbability * 100))%")
                    Slider(value: $explodeProbability, in: 0.05...0.20, step: 0.01)
                }
                .padding()
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
