import SwiftUI

struct Stage1MenuView: View {
    @State private var selectedTab = 0
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    var body: some View {
        TabView(selection: $selectedTab) {
            VStack{
                HStack{
                    Image("stage1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)

                    Text(welcome)
                        .font(.custom("Avenir", size: 50)
                            .weight(.bold))
                        .foregroundColor(Color("stage1Brown"))
                        .padding(10)
                }
                Divider()
                .padding(20)
                Text(IntroDescription)
                    .font(.custom("Courier", size: 30))
                    .foregroundColor(Color("stage1Pink"))
                    .padding(20)
            }
                .tag(0)
            
            
            VStack{
                Text("Option 1: Finding Niche")
                    .font(.custom("Avenir", size: 50)
                        .weight(.bold))
                    .foregroundColor(Color("stage1Brown"))
                    .padding(10)
                Divider()
                .padding(20)
                Text(opt1Description)
                    .font(.custom("Courier", size: 30))
                    .foregroundColor(Color("stage1Pink"))
                    .padding(20)
            }
            .tag(1)
            
            VStack{
                Text("Option 2: Finding Suppliers")
                    .font(.custom("Avenir", size: 50)
                        .weight(.bold))
                    .foregroundColor(Color("stage1Brown"))
                    .padding(10)
                Divider()
                .padding(20)
                Text(opt2Description)
                    .font(.custom("Courier", size: 30))
                    .foregroundColor(Color("stage1Pink"))
                    .padding(20)
            }
            .tag(2)
            
            VStack{
                Text("Ending a Round")
                    .font(.custom("Avenir", size: 50)
                        .weight(.bold))
                    .foregroundColor(Color("stage1Brown"))
                    .padding(10)
                Divider()
                .padding(20)
                Text(endDescription)
                    .font(.custom("Courier", size: 30))
                    .foregroundColor(Color("stage1Pink"))
                    .padding(20)
            }
            .tag(3)
            VStack{
                Text("About the Goal")
                    .font(.custom("Avenir", size: 50)
                        .weight(.bold))
                    .foregroundColor(Color("stage1Brown"))
                    .padding(10)
                Divider()
                .padding(20)
                Text(goalDescription)
                    .font(.custom("Courier", size: 30))
                    .foregroundColor(Color("stage1Pink"))
                    .padding(20)
            }
            .tag(4)
            
            VStack{
                Text("Operation Comparison")
                    .font(.custom("Courier", size: 50)
                        .weight(.bold))
                    .foregroundColor(Color("stage1Green"))
                
                    .padding(30)
                
                LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(0..<12) { index in
                                    let row = index / 4
                                    let column = index % 4
                                    Text(introArr[row][column])
                                        .fontWeight(row == 0 ? .bold : .regular)
                                        
                                }
                            }
                            .padding()
            }
                .tag(5)
            
            
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
