//
//  ResultView.swift
//  ANIMAL BALLAGE
//
//  Created by 渡辺幹 on 2022/03/03.
//

import SwiftUI

struct ResultView: View {
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    @ObservedObject var gvm: GameViewModel = .GVM
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Button(action: {
                        gvm.changeMode(Mode: "home")
                        gvm.resetAll()
                        gvm.nowBGM = gvm.audio.stopMusic(now: gvm.nowBGM)
                    }){
                        Image(systemName: "house.circle")
                            .resizable()
                            .frame(width: w/10, height: w/10)
                            .foregroundColor(.black)
                    }
                    if !gvm.isOnline {
                        Button(action: {
                            gvm.changeMode(Mode: "battle")
                            gvm.resetAll()
                            gvm.startCount()
                        }){
                            Image(systemName: "arrow.counterclockwise")
                                .resizable()
                                .frame(width: w/11, height: w/10)
                                .foregroundColor(.black)
                        }
                    }
                    
                    Spacer()
                    Text("\(gvm.dt.difficulty)")
                        .font(.system(.title3, design: .serif))
                        .foregroundColor(Color.green)
                    Text("\(gvm.dt.gameTime)秒")
                        .font(.system(.title3, design: .serif))
                        .foregroundColor(Color.black)
                }.padding(5)
                Spacer()
                resultLabel()
                Spacer()
                VStack(spacing: 0){
                    Group{
                        HStack{
                            Text("\(gvm.dt.score1)").font(.title)
                            Text("スコア").font(.largeTitle)
                            Text("\(gvm.dt.score2)").font(.title)
                        }
                        HStack{
                            Text("\(gvm.dt.tap1)").font(.title)
                            Text("タップ").font(.largeTitle)
                            Text("\(gvm.dt.tap2)").font(.title)
                        }
                        HStack{
                            Text("\(gvm.dt.miss1)").font(.title)
                            Text("ミス").font(.largeTitle)
                            Text("\(gvm.dt.miss2)").font(.title)
                        }
                    }.frame(width: w*0.7, height: h/15)
                        .border(Color.black)
                        .background(Color.white)
                    
                }
                Spacer().frame(height: h/10)
            }
        }
    }
}

struct resultLabel: View {
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    @ObservedObject var gvm: GameViewModel = .GVM
    let colorList: [Color] = [.red, .gray, .blue]
    @State var resultMessage = ""
    @State var iconSize1 = CGFloat(100)
    @State var iconSize2 = CGFloat(100)
    var body: some View {
        VStack{
            Text("\(resultMessage)")
                .font(.largeTitle)
                .foregroundColor(colorList[gvm.dt.result])
            HStack{
                VStack(spacing: 5){
                    if gvm.dt.result == 2 {
                        Spacer().frame(height: w/10)
                    }
                    Image("\(gvm.dt.animal1)")
                        .resizable()
                        .frame(width: iconSize1, height: iconSize1)
                    Text("\(gvm.dt.name1)")
                        .font(.title3)
                }
                Image("VS")
                    .resizable()
                    .frame(width: w*0.15, height: w*0.15)
                
                VStack(spacing: 5){
                    if gvm.dt.result == 0 {
                        Spacer().frame(height: w/10)
                    }
                    Image("\(gvm.dt.animal2)")
                        .resizable()
                        .frame(width: iconSize2, height: iconSize2)
                    Text("\(gvm.dt.name2)")
                        .font(.title3)
                }
            }
        }.onAppear(){adaptation()}
    }
    
    func adaptation() {
        iconSize1 = w/3.5
        iconSize2 = w/3.5
        if gvm.dt.result == 0 {iconSize1 = w/2.5; resultMessage = "YouWin"}
        if gvm.dt.result == 1 {resultMessage = "Draw"}
        if gvm.dt.result == 2 {iconSize2 = w/2.5; resultMessage = "YouLose"}
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView()
    }
}
