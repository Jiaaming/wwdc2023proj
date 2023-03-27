import SwiftUI

struct StartPageView: View {
    @State var jumpToGame = false
    @State var jumpToIntro = false
    var body: some View {
        ZStack {
            Image("background")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .edgesIgnoringSafeArea(.all)
                            .opacity(0.8)
            //Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white.opacity(0.9))
                        .frame(width: 950, height: 150)
                        
                    Text("RiskMaster Inc.")
                        .font(.custom("Courier", size: 90))
                        .foregroundColor(.black)
                        //.fontWeight(.bold)
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
                        .foregroundColor(.black)
                }.padding(10)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.white.opacity(0.9))
                        .frame(width: 350, height: 50)
                    
                    Button("> Brief Introduction"){
                        self.jumpToIntro.toggle()
                    }.navigationBarTitle("首页", displayMode: .inline)//设置标题，并固定到导航中间
                        .sheet(isPresented: $jumpToIntro) {
                            //非全屏模式
                            //ShortIntroductionView()
                            Stage1MenuView()
                        }
                        .font(.custom("Courier", size: 25))
                        .foregroundColor(.black)
                }
                
                
                
                
                Spacer()
            }
        }
        
    }
}


