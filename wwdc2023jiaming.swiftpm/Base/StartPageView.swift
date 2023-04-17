import SwiftUI

struct StartPageView: View {
    @State var jumpToGame = false
    @State var jumpToIntro = false
    var body: some View {
        ZStack {
            BackgroundView()
            //Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white.opacity(0.9))
                        .frame(width: 950, height: 350)
                     
                    VStack{
                        Text("")
                            .font(.custom("Courier", size: 120))
                            .foregroundColor(.black)

                        Text("Apple Ascendancy")
                            .font(.custom("Courier", size: 90))
                            .foregroundColor(.black)
                            //.fontWeight(.bold)
                            
                        Text("Mastermind at the Helm")
                            .font(.custom("Courier", size: 60))
                            .foregroundColor(.black)
                            //.fontWeight(.bold)
                            .padding(-5)
                    }
                    
                }
                Spacer(minLength: 10)

                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.white.opacity(0.9))
                        .frame(width: 350, height: 50)
                    
                    Button("> Tap Here to Start"){
                        self.jumpToGame.toggle()

                    }
                        .fullScreenCover(isPresented: $jumpToGame, content: {
                                //全屏模式
                                BootstrappingView()
                        })
                        .font(.custom("Courier", size: 25))
                        
                    
                    
                }.padding(10)
        
                
                Spacer()
            }
        }
        
    }
}


