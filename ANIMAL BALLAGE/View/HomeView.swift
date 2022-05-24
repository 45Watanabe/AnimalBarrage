//
//  HomeView.swift
//  ANIMAL BALLAGE
//
//  Created by 渡辺幹 on 2022/03/03.
//

import SwiftUI

struct HomeView: View {
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    @ObservedObject var gvm: GameViewModel = .GVM
    var body: some View {
        ZStack{
            VStack{
                Spacer().frame(height: 1)
                settingTile()
                whiteBord()
                Spacer()
                
                HStack{
                    ZStack{
                        Image("frame")
                            .resizable()
                            .frame(width: w/2.7, height: w/2.7)
                        Button(action: {}){
                            Image("\(gvm.dt.animal1)")
                                .resizable()
                                .frame(width: w/3, height: w/3)
                        }
                    }
                    Image("VS")
                        .resizable()
                        .frame(width: w*0.15, height: w*0.15)
                    ZStack{
                        Image("frame")
                            .resizable()
                            .frame(width: w/2.7, height: w/2.7)
                        Button(action: {gvm.changeEnemy()}){
                            Image("\(gvm.dt.animal2)")
                                .resizable()
                                .frame(width: w/3, height: w/3)
                        }
                    }
                }
                Button(action: {
                    gvm.changeMode(Mode: "battle")
                    gvm.startCount()
                }) {
                    Image("FIGHT")
                        .resizable()
                        .frame(width: 130, height: 70)
                }
                Spacer()
                HStack{
                    ForEach(0..<5){ i in
                        animalSelectButtton(num: i)
                    }
                }
                HStack{
                    ForEach(5..<8){ i in
                        animalSelectButtton(num: i)
                    }
                }
                Spacer().frame(height: h/20)
            }
        }
    }
}

struct settingTile: View {
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    @ObservedObject var gvm: GameViewModel = .GVM
    let color: [Color] = [.yellow,.green,.red,.black]
    let difficultyList = ["EASY","NORMAL","HARD","CRAZY"]
    var body: some View {
        ZStack{
            VStack(spacing: 5){
                HStack{
                    Image("\(gvm.dt.animal1)ボタン")
                        .resizable()
                        .frame(width: w/15, height: w/15)
                    TextField("名前を入力してください", text: $gvm.dt.name1)
                        .font(.system(.title3, design: .rounded))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        Spacer()
//                    Button(action: {}){
//                        Image(systemName: "gearshape.2")
//                            .resizable()
//                            .frame(width: w/10, height: w/14)
//                            .foregroundColor(.black)
//                    }
                }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                HStack{
                    HStack(spacing: 3){
                        ForEach(0..<4){ i in
                            if gvm.dt.difficulty == difficultyList[i] {
                                Text("\(gvm.dt.difficulty)")
                                    .font(.system(.title3, design: .serif))
                                    .foregroundColor(color[i])
                                    .frame(width: w/4)
                            }
                        }
                        Button(action: {
                            if gvm.select == "" || gvm.select == "pushAnimal"
                            {gvm.select = "difficultyTile"} else {gvm.select = ""}
                        }){
                            Image(systemName: "chevron.down.square.fill")
                                .resizable()
                                .frame(width: w/25, height: w/25)
                                .foregroundColor(.black)
                        }
                    }
                    
//                    Text("\(gvm.dt.gameTime)秒")
//                        .font(.system(.title3, design: .serif))
//                        .foregroundColor(Color.black)
                    Button(action: {gvm.changeMode(Mode: "matching")}){
                        Image(systemName: "network")
                            .resizable()
                            .frame(width: w/13, height: w/13)
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Button(action: {gvm.changeMode(Mode: "special")
                        gvm.backGround = "SPACIAL\(Int.random(in: 1...3))"}){
                        Image("spBtn")
                            .resizable()
                            .frame(width: w/10, height: w/10)
                            .foregroundColor(.black)
                    }
                    Button(action: {gvm.getlog()
                        gvm.changeMode(Mode: "log")
                        gvm.backGround = "LOG"}){
                        Image("logBtn")
                            .resizable()
                            .frame(width: w/10, height: w/10)
                            .foregroundColor(.black)
                    }
                    Button(action: {gvm.getRanking(animal: gvm.dt.animal1)
                        gvm.changeMode(Mode: "ranking")
                        gvm.backGround = "RANKING"}){
                        Image("rankBtn")
                            .resizable()
                            .frame(width: w/10, height: w/10)
                            .foregroundColor(.black)
                    }
                }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
        }.frame(width: w*0.95, height: h*0.1)
        .background(Color.white)
    }
}

struct animalSelectButtton: View {
    @ObservedObject var gvm: GameViewModel = .GVM
    let animalList = ["犬","猫","鳥","狼","リス","人間","駝鳥","梟"]
    let num: Int
    var body: some View {
        Button(action: {gvm.dt.animal1 = animalList[num]
            gvm.select = "pushAnimal"}){
            Image(animalList[num])
                .resizable()
                .frame(width: UIScreen.main.bounds.width/6,
                       height: UIScreen.main.bounds.width/6)
        }
    }
}

struct whiteBord: View {
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    @ObservedObject var gvm: GameViewModel = .GVM
    let difficultyList = ["EASY","NORMAL","HARD","CRAZY"]
    let color: [Color] = [.yellow,.green,.red,.black]
    var body: some View {
        ZStack{
            VStack{}
                .frame(width: w*0.95, height: h/7)
                .background(Color.white)
                .opacity(0.3)
            if gvm.select == "difficultyTile"{
                HStack(spacing: 0){
                    VStack{
                        ForEach(0..<4){ i in
                            Button(action: {
                                gvm.dt.difficulty = difficultyList[i]
                                gvm.backGround = difficultyList[i]
                            }){
                                Text("\(difficultyList[i])")
                                    .font(.system(.title3, design: .serif))
                                    .foregroundColor(color[i])
                                    .shadow(color: Color.white, radius: 5, x: 5, y: 5)
                            }
                        }
                    }.frame(width: w*0.3, height: h/8)
                        
                    VStack(spacing: 0){
                        ForEach(0..<4){ i in
                            Image("white")
                                .resizable()
                                .frame(width: 1, height: h/32)
                                .opacity(gvm.dt.difficulty == difficultyList[i] ?
                                         0 : 1.0)
                        }
                    }
                    VStack{
                        Group{
                            if gvm.dt.difficulty == "EASY" {
                                Text("EASYモード\nスコアが二倍の\n簡単モード。")
                            } else if gvm.dt.difficulty == "NORMAL" {
                                Text("NORMALモード\nスコア倍率なしの\n通常モード。")
                            } else if gvm.dt.difficulty == "HARD" {
                                Text("HARDモード\nタップをミスするとペナルティ！")
                            } else if gvm.dt.difficulty == "CRAZY" {
                                Text("CRAZYモード\n10秒毎にトラップが出現。")
                            }
                        }.foregroundColor(Color.white)
                        
                        Button(action: {
                            gvm.select = ""
                        }){
                            Text("OK")
                                .font(.system(.title3, design: .serif))
                        }
                    }.frame(width: w*0.65, height: h/8)
                        
                }.padding(5)
                .border(Color.white, width: 3)
                    .border(Color.black, width: 2)
                    .background(Color.gray)
                
            }
            
            if gvm.select == "pushAnimal"{
                HStack(spacing: 0){
                    VStack(spacing: 2){
                        HStack{
                            Image("\(gvm.dt.animal1)ボタン")
                                .resizable()
                                .frame(width: w/15, height: w/15)
                            Text("\(gvm.dt.animal1)")
                                .font(.callout)
                        }
                        Image("\(gvm.dt.animal1)")
                            .resizable()
                            .frame(width: w/5, height: w/5)
                    }.frame(width: w/4)
                    Spacer()
                    Text("\(animalInfoList().getText(animal: gvm.dt.animal1))")
                        .font(.caption)
                        .frame(width: w/1.5)
                    Spacer()
                }.padding(5).frame(width: w*0.95, height: h/7)
                .border(Color.white, width: 3)
                    .border(Color.black, width: 2)
                    .background(Color.gray)
                    
            }
        }
    }
}

class animalInfoList {
    let infoList = [
        "1タップ 3ポイント\n中心に動かぬボタンがひとつ。とてもシンプルな動物\nただひたすら連打！\n体が資本。あなたの連打力が試される...",
        "1タップ 9ポイント\nボタンをタップするとボタンがランダムな位置に移動！\n移動したボタンを素早くタップ！\n瞬発力の権化となれ...",
        "1タップ 6ポイント\nボタンをタップすると横に移動。端まで行くと縦に移動！\nひたすら追ってタップ！\n正確性と集中力が問われる...",
        "1タップ 4ポイント\nボタンが画面右側と左側を行き来する。\n両手の指を使い素早く連打！\n使いこなすには判断力と集中力が必要だ...",
        "3タップ 14ポイント\nボタンが3つ出現するのだ！\n散らばった3つのボタンを素早く集めるのだ！\n瞬発力と集中力をささげるのだ...",
        "???\nその生き物は語る「人生はガチャ」と。\nガチャ石を素早く集めて賭けに挑戦だ！\n賭け事こそ労働！人生は運が全て！",
        "1タップ 4ポイント\n隣接した2個のボタンを上まで運ぼう！\nボタンを押す順番は自由！盤上を駆け巡れ！\n正確性と集中力が問われる...",
        "1タップ 1~9ポイント\n中心と外側、二種類のボタンが出現。\n外側のボタンの方が得点が高い\n正確性と集中力が問われる...",
    ]
    func getText(animal: String) -> String {
        var info = ""
        switch animal {
        case "犬": info = infoList[0]
        case "猫": info = infoList[1]
        case "鳥": info = infoList[2]
        case "狼": info = infoList[3]
        case "リス": info = infoList[4]
        case "人間": info = infoList[5]
        case "駝鳥": info = infoList[6]
        case "梟": info = infoList[7]
        default: break
        }
        return info
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
