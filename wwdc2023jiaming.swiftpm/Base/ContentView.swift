import SwiftUI

enum GameStage {
    case bootstrapping
    case growth
    case maturity
}

struct ContentView: View {
    @State private var currentStage: GameStage = .bootstrapping

    var body: some View {
        NavigationView {
            VStack {
                switch currentStage {
                case .bootstrapping:
                    BootstrappingView(stageCompleted: {
                        currentStage = .growth
                    })
                case .growth:
                    GrowthView(stageCompleted: {
                        currentStage = .maturity
                    })
                case .maturity:
                    MaturityView(stageCompleted: {
                        currentStage = .maturity
                    })
                }
            }
        }

    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
