//
//  SpacialView.swift
//  ANIMAL BALLAGE
//
//  Created by 渡辺幹 on 2022/03/28.
//

import SwiftUI

struct SpacialView: View {
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    @ObservedObject var gvm: GameViewModel = .GVM
    @State var isMusicBord = true
    var body: some View {
        ZStack{
            VStack{
                ZStack{
                    Image("egg1")
                        .resizable()
                        .frame(width: h/3, height: h/3)
                    Text("あと\(gvm.eggCount)回")
                        .font(.largeTitle)
                        .underline()
                }
                Spacer().frame(height: w*1.1+h/10)
            }
            VStack{
                HStack{
                    Button(action: {
                        gvm.changeMode(Mode: "home")
                        gvm.resetAll()
                        gvm.backGround = gvm.dt.difficulty
                    }){
                        Image(systemName: "house.circle")
                            .resizable()
                            .frame(width: w/10, height: w/10)
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                Spacer().frame(height: h/4)
                HStack{
                    ForEach(0..<7){ i in
                        animalChangeButtton(num: i)
                    }
                }
                Spacer().frame(height: w+h/10)
            }
            /*
            VStack{
                HStack{
                    Spacer()
                    ZStack{
                        if isMusicBord {musicBord()}
                        Button(action: {isMusicBord.toggle()}){
                            Image(systemName: "chevron.down.square.fill")
                                .resizable()
                                .frame(width: w/20, height: w/20)
                                .foregroundColor(.black)
                        }
                    }
                }
                Spacer()
            }
            */
            buttonView()
        }
    }
}

struct eggView: View {
    @ObservedObject var gvm: GameViewModel = .GVM
    @State var eggImage = "egg1"
    var body: some View {
        Image("\(setEggImage())")
            .resizable()
            .frame(width: UIScreen.main.bounds.height/3,
                   height: UIScreen.main.bounds.height/3)
    }
    func setEggImage() -> String {
        var result = ""
        switch gvm.eggCount {
        case ...100000: result = "egg1"
        case ...90000: result = "egg2"
        case ...80000: result = "egg3"
        case ...60000: result = "egg4"
        case ...40000: result = "egg5"
        case ...30000: result = "egg6"
        case ...20000: result = "egg7"
        case ...10000: result = "egg8"
        case 0: result = "egg9"
        default: break
        }
        
        return result
    }
}

struct animalChangeButtton: View {
    @ObservedObject var gvm: GameViewModel = .GVM
    @ObservedObject var bvm: buttonViewModel = .bVM
    let animalList = ["犬","猫","鳥","狼","リス","駝鳥","梟"]
    let num: Int
    var body: some View {
        Button(action: {
            gvm.dt.animal1 = animalList[num]
            gvm.resetAll()
            bvm.setPosition()
        }){
            Image(animalList[num])
                .resizable()
                .frame(width: UIScreen.main.bounds.width/9,
                       height: UIScreen.main.bounds.width/9)
        }
    }
}

struct musicBord: View {
    var body: some View {
        ZStack{
            VStack{
                ForEach(0..<4){ c in
                    HStack{
                        ForEach(1..<4){ b in
                            musicPlayButton(colorNum: c,
                                            bgmNum: b)
                        }
                    }
                }
            }
        }.frame(width: UIScreen.main.bounds.width*0.4,
                height: UIScreen.main.bounds.width*0.5)
        .border(Color.black)
    }
}

struct musicPlayButton: View {
    let w = UIScreen.main.bounds.width
    let diffuculty = ["EASY","NORMAL","HARD","CRAZY"]
    let colorList: [Color] = [.yellow,.green,.red,.white]
    var colorNum: Int
    var bgmNum: Int
    let audio = Audio()
    var body: some View {
        Button(action: {
            audio.playMusic(order: "\(diffuculty[bgmNum])\(bgmNum)")
        }){
            ZStack{
                Image(systemName: "square.fill")
                    .resizable()
                    .frame(width: w/10, height: w/10)
                    .foregroundColor(Color.black)
                Image(systemName: "play.fill")
                    .resizable()
                    .frame(width: w/20, height: w/20)
                    .foregroundColor(colorList[colorNum])
                Image(systemName: "\(bgmNum).circle")
                    .resizable()
                    .frame(width: w/25, height: w/25)
                    .position(x: w/13 , y: w/50)
                    .foregroundColor(Color.white)
            }.frame(width: w/10, height: w/10)
        }
    }
}

struct SpacialView_Previews: PreviewProvider {
    static var previews: some View {
        SpacialView()
    }
}
