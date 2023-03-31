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
                Text(welcome2)
                    .font(.custom("Courier", size: 30))
                    //.foregroundColor(Color("stage1Pink"))
                    .padding(20)
            }
            .tag(0)
            
            VStack{
                HStack{
                    Text("🤔What should I do?")
                        .font(.custom("Avenir", size: 50)
                            .weight(.bold))
                        .foregroundColor(Color("stage1Brown"))
                        .padding(10)
                    
                    
                }
                Divider()
                    .padding(20)
                Text(IntroDescription)
                    .font(.custom("Courier", size: 30))
                    //.foregroundColor(Color("stage1Pink"))
                    .padding(20)
            }
            .tag(1)
            
            VStack{
                Text("Option 1: -MacSafe-")
                    .font(.custom("Avenir", size: 50)
                        .weight(.bold))
                    .foregroundColor(Color("stage1Brown"))
                    .padding(10)
                Divider()
                    .padding(20)
                Text(opt1Description)
                    .font(.custom("Courier", size: 30))
                    //.foregroundColor(Color("stage1Pink"))
                    .padding(20)
            }
            .tag(2)
            
            VStack{
                Text("Option 2: -iRisky-")
                    .font(.custom("Avenir", size: 50)
                        .weight(.bold))
                    .foregroundColor(Color("stage1Green"))
                    .padding(10)
                Divider()
                    .padding(20)
                Text(opt2Description)
                    .font(.custom("Courier", size: 30))
                    //.foregroundColor(Color("stage1Pink"))
                    .padding(20)
            }
            .tag(3)
            
            VStack{
                Text("Ending a Round: Harvest Profits")
                    .font(.custom("Avenir", size: 50)
                        .weight(.bold))
                    .foregroundColor(Color("stage1Pink"))
                    .padding(10)
                Divider()
                    .padding(20)
                Text(endDescription)
                    .font(.custom("Courier", size: 30))
                    //.foregroundColor(Color("stage1Pink"))
                    .padding(20)
            }
            .tag(4)
            
            VStack{
                Text("Succeed or Fail")
                    .font(.custom("Avenir", size: 50)
                        .weight(.bold))
                    .foregroundColor(Color("stage1Brown"))
                    .padding(10)
                Divider()
                    .padding(20)
                Text(alarmDescription)
                    .font(.custom("Courier", size: 30))
                    //.foregroundColor(Color("stage1Pink"))
                    .padding(20)
            }
            .tag(5)
            
            VStack{
                Text("⚽️About the Goal")
                    .font(.custom("Avenir", size: 50)
                        .weight(.bold))
                    .foregroundColor(Color("stage1Brown"))
                    .padding(10)
                Divider()
                    .padding(20)
                Text(goalDescription)
                    .font(.custom("Courier", size: 30))
                    //.foregroundColor(Color("stage1Pink"))
                    .padding(20)
            }
            .tag(6)
            
            VStack{
                Text("🏃Let's start!!")
                    .font(.custom("Courier", size: 50)
                        .weight(.bold))
                    .foregroundColor(Color("stage1Green"))
                Divider()
                
                    .padding(20)
                Text(lastDescription)
                    .font(.custom("Courier", size: 30))
                    //.foregroundColor(Color("stage1Pink"))
                    .padding(20)
            }
            .tag(7)
            
            
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

struct Stage1MenuView_Previews: PreviewProvider {
    static var previews: some View {
        Stage1MenuView()
    }
}
