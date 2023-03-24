import SwiftUI

struct StartPageView: View {
    @State var jumpToGame = false
    @State var jumpToIntro = false
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                        .frame(width: 950, height: 150)
                    
                    Text("CorporateRisk Tycoon")
                        .font(.custom("Avenir", size: 90))
                        .foregroundColor(.black)
                }
                
                Spacer(minLength: 10)
                
                Button("> Tap Here to Start"){
                    self.jumpToGame.toggle()

                }
                    .fullScreenCover(isPresented: $jumpToGame, content: {
                            //全屏模式
                            ContentView()
                    })
                    .font(.custom(kRetroFontName, size: 25))
                    .foregroundColor(.black)
                
                Spacer()
                
                Button("> Brief Introduction"){
                    self.jumpToIntro.toggle()
                }.navigationBarTitle("首页", displayMode: .inline)//设置标题，并固定到导航中间
                    .sheet(isPresented: $jumpToIntro) {
                        //非全屏模式
                        ShortIntroductionView()
                    }
                    .font(.custom(kRetroFontName, size: 25))
                    .foregroundColor(.black)
                
                Spacer()
            }
        }
        
    }
}

private let kRetroFontName = "Courier"
