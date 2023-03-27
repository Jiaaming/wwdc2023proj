import SwiftUI

enum GameStage {
    case bootstrapping
    case growth
    case maturity
}

import SwiftUI



struct ContentView: View {
    @State private var currentStage: GameStage = .bootstrapping

    var body: some View {

        
            StartPageView()
        

    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
