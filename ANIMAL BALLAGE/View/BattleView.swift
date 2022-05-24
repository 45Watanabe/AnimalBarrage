//
//  BattleView.swift
//  ANIMAL BALLAGE
//
//  Created by 渡辺幹 on 2022/03/03.
//

import SwiftUI

struct BattleView: View {
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    @ObservedObject var gvm: GameViewModel = .GVM
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                HStack{
                    if !gvm.isOnline {
                        Button(action: {gvm.changeMode(Mode: "home")
                            gvm.resetAll()
                        }){
                            Image(systemName: "escape")
                                .resizable()
                                .frame(width: w/10, height: w/10)
                                .foregroundColor(.black)
                        }
                    }
                    
                    Spacer()
                    ZStack{
                        Image("clock")
                            .resizable()
                            .frame(width: w/8, height: w/8)
                            .foregroundColor(.black)
                        Text("\(gvm.count)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(gvm.count<=3 ? .red:.black)
                    }
                }
                HStack{
                    VStack(spacing: 5){
                        if gvm.dt.difficulty == "EASY" {
                            Text("\(gvm.dt.score1*2)").font(.title)
                        } else {
                            Text("\(gvm.dt.score1)").font(.title)
                        }
                        Image("\(gvm.dt.animal1)")
                            .resizable()
                            .frame(width: w/3, height: w/3)
                        Text("\(gvm.dt.name1)")
                            .font(.system(.title3, design: .rounded))
                    }
                    Image("VS")
                        .resizable()
                        .frame(width: w*0.15, height: w*0.15)
                        .padding()
                    VStack(spacing: 5){
                        if gvm.dt.difficulty2 == "EASY" {
                            Text("\(gvm.dt.score2*2)").font(.title)
                        } else {
                            Text("\(gvm.dt.score2)").font(.title)
                        }
                        Image("\(gvm.dt.animal2)")
                            .resizable()
                            .frame(width: w/3, height: w/3)
                        Text("\(gvm.dt.name2)")
                            .font(.system(.title3, design: .rounded))
                    }
                }
                Spacer().frame(height: w+h/10)
            }
            buttonView()
            if gvm.three > 0 {
                countDown()
            }
            if gvm.count == 0 {
                finishView()
            }
        }
    }
    
}

struct countDown: View {
    @ObservedObject var gvm: GameViewModel = .GVM
    var body: some View {
        ZStack{
            Image("Brack")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.8)
            VStack{
                Text("ゲーム開始まで")
                    .font(.title2)
                    .foregroundColor(.white)
                HStack{
                    Text("\(gvm.three)")
                        .font(.title)
                        .foregroundColor(.white)
                    Text("秒")
                        .font(.title3)
                        .foregroundColor(.white)
                }
            }
        }.border(Color.white,width: 6)
            .border(Color.gray,width: 3)
    }
}

struct finishView: View {
    @ObservedObject var gvm: GameViewModel = .GVM
    var body: some View {
        ZStack{
            Image("Brack")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.8)
            VStack{
                Text("終了！")
                    .font(.system(size: 100, weight: .black, design: .default))
                    .foregroundColor(Color.white)
                Button(action: {
                    gvm.changeMode(Mode: "result")
                    gvm.finishGame()
                }){
                    Text("リザルト画面へ")
                        .font(.title)
                        .foregroundColor(Color.white)
                }
            }
        }.border(Color.white,width: 6)
            .border(Color.gray,width: 3)
    }
}

struct BattleView_Previews: PreviewProvider {
    static var previews: some View {
        BattleView()
    }
}
