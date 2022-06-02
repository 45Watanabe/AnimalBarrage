//
//  buttonView.swift
//  ANIMAL BALLAGE
//
//  Created by 渡辺幹 on 2022/03/16.
//

import SwiftUI

class buttonViewModel: ObservableObject {
    private init (){}
    static let bVM = buttonViewModel()
    @ObservedObject var gvm: GameViewModel = .GVM
    let audio = Audio()
    @Published var btnCount = 1
    @Published var buttonImg = ["","",""]
    @Published var btns = (num:0,x1:0,y1:0,x2:0,y2:0,x3:0,y3:0)
    @Published var n = 0
    @Published var c = 0
    @Published var backGround: (Double, Bool) = (0.3, false)
    
    //    ボタンの初期位置、数のセット
    func setPosition() {
        print("aaaaaa----")
        n = 0
        c = 0
        buttonImg = ["","",""]
        switch gvm.dt.animal1 {
        case "犬":btns = (num:1,x1:4,y1:4,x2:0,y2:0,x3:0,y3:0)
        case "猫":btns = (num:1,x1:4,y1:4,x2:0,y2:0,x3:0,y3:0)
        case "鳥":btns = (num:1,x1:1,y1:4,x2:0,y2:0,x3:0,y3:0)
        case "狼":btns = (num:1,x1:2,y1:4,x2:0,y2:0,x3:0,y3:0)
        case "リス":btns = (num:3,x1:4,y1:4,x2:4,y2:4,x3:4,y3:4)
            n = 2
        case "人間":btns = (num:1,x1:4,y1:2,x2:0,y2:0,x3:0,y3:0)
        case "駝鳥":btns = (num:2,x1:3,y1:7,x2:4,y2:7,x3:0,y3:0)
        case "梟":btns = (num:2,x1:3,y1:3,x2:4,y2:4,x3:0,y3:0)
        case "兎":btns = (num:2,x1:4,y1:2,x2:4,y2:5,x3:0,y3:0)
            buttonImg[0] = "餌"
        default:btns = (num:1,x1:4,y1:4,x2:0,y2:0,x3:0,y3:0)
        }
        btnCount = btns.num
    }
    
    //    ボタンを押した時の処理
    func push(pushed: Int) {
        if gvm.mode == "special" {gvm.eggCount -= 1}
        audio.buttonSound(animal: gvm.dt.animal1)
        gvm.dt.tap1 += 1
        if gvm.dt.animal1 == "犬"{
            btns.x1 = 4
            btns.y1 = 4
            gvm.dt.score1 += 3
        }
        if gvm.dt.animal1 == "猫"{
            btns.x1 = Int.random(in: 1...7)
            btns.y1 = Int.random(in: 1...7)
            gvm.dt.score1 += 9
        }
        if gvm.dt.animal1 == "鳥"{
            n+=1
            if n == 7 {
                c = Int.random(in: 0...1)
                if c == 0 {btns.x1 = 1}
                if c == 1 {btns.x1 = 7}
                btns.y1 = Int.random(in: 1...7)
                n = 0
            } else {
                if c == 0 {btns.x1 += 1}
                if c == 1 {btns.x1 -= 1}
            }
            gvm.dt.score1 += 6
        }
        if gvm.dt.animal1 == "狼"{
            btns.y1=4
            n = Int.random(in: 1...50)
            if c == 0 {
                switch n {
                case 1...2:btns.x1 = 5
                case 3...4:btns.x1 = 7
                case 5...50:btns.x1 = 6
                default:btns.x1 = 6
                }
                c = 1
            }else{
                switch n {
                case 1...2:btns.x1 = 1
                case 3...4:btns.x1 = 3
                case 5...50:btns.x1 = 2
                default:btns.x1 = 2
                }
                c = 0
            }
            gvm.dt.score1 += 4
        }
        if gvm.dt.animal1 == "リス"{
            if n == 2 {
                gvm.dt.score1 += 14
                btns.x1 = Int.random(in: 1...7)
                btns.y1 = Int.random(in: 1...7)
                btns.x2 = Int.random(in: 1...7)
                btns.y2 = Int.random(in: 1...7)
                btns.x3 = Int.random(in: 1...7)
                btns.y3 = Int.random(in: 1...7)
                n = 0
            }else{
                if pushed == 1 {btns.x1 = -2}
                if pushed == 2 {btns.x2 = -2}
                if pushed == 3 {btns.x3 = -2}
                n+=1
            }
        }
        if gvm.dt.animal1 == "人間"{
            if pushed == 1 {
                n+=1
                btns.x1 = Int.random(in: 1...7)
                btns.y1 = Int.random(in: 1...3)
            } else {
                if n >= 5 {
                    n-=5
                    c=Int.random(in: 1...100)
                    if (c==1){gvm.dt.score1+=1200} // 1%
                    if (c==2){gvm.dt.score1-=5000} // 1%
                    if (c>=3&&c<=7){gvm.dt.score1-=1000} // 5%
                    if (c>=8&&c<=17){gvm.dt.score1+=200} // 10%
                    if (c>=18&&c<=37){gvm.dt.score1+=100} // 20%
                    if (c>=38&&c<=67){gvm.dt.score1+=50} // 30%
                    if (c>=68&&c<=100){gvm.dt.score1-=50} // 33%
                }
            }
        }
        if gvm.dt.animal1 == "駝鳥"{
            n+=1
            if n == 14 {
                btns.x1 = Int.random(in: 1...6)
                btns.x2 = btns.x1 + 1
                btns.y1 = 7
                btns.y2 = 7
                n = 0
            } else {
                if pushed == 1 {btns.y1 -= 1}
                if btns.y1 == 0 {btns.x1 = -3}
                if pushed == 2 {btns.y2 -= 1}
                if btns.y2 == 0 {btns.x2 = -3}
            }
            gvm.dt.score1 += 4
        }
        if gvm.dt.animal1 == "梟"{
            n+=1
            if pushed==2{
                gvm.dt.score1 -= 2
            }
            if n<3{btns.x1+=1
                gvm.dt.score1 += 3
            }else if n<5{btns.y1+=1
                gvm.dt.score1 += 4
            }else if n<7{btns.x1-=1
                gvm.dt.score1 += 5
            }else if n<9{btns.y1-=1
                gvm.dt.score1 += 6
            }else if n<11{btns.x1+=1
                gvm.dt.score1 += 7
            }else if n<13{btns.y1+=1
                gvm.dt.score1 += 8
            }else if n==13{
                gvm.dt.score1 += 9
                c=Int.random(in: 2...6)
                btns.x1=c-1
                btns.x2=c
                c=Int.random(in: 2...6)
                btns.y1=c-1
                btns.y2=c
                n=0
            }
        }
        if gvm.dt.animal1 == "兎"{
            switch pushed {
            case 6:if btns.y2 != 1 {btns.y2-=1}
            case 7:if btns.x2 != 1 {btns.x2-=1}
            case 8:if btns.x2 != 7 {btns.x2+=1}
            case 9:if btns.y2 != 7 {btns.y2+=1}
            default:gvm.dt.miss1 += 1
            }
            if btns.x1 == btns.x2 && btns.y1 == btns.y2{
                gvm.dt.score1 += 30
                while btns.x1 == btns.x2 && btns.y1 == btns.y2{
                    btns.x1 = Int.random(in: 1...7)
                    btns.y1 = Int.random(in: 1...7)
                    btns.x2 = Int.random(in: 1...7)
                    btns.y2 = Int.random(in: 1...7)
                }
            }
        }
    }
    
    func missTap() {
        gvm.dt.miss1 += 1
        if gvm.dt.difficulty == "HARD" ||
            gvm.dt.difficulty == "CRAZY" {
            gvm.dt.score1 -= 5
        }
        backGround = (0.3, true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.backGround = (0.3, false)
        }
    }
    
}

struct buttonView: View {
    let w = UIScreen.main.bounds.width*0.95
    let h = UIScreen.main.bounds.height
    @ObservedObject var gvm: GameViewModel = .GVM
    @ObservedObject var bvm: buttonViewModel = .bVM
    var body: some View {
        VStack{
            Spacer()
            ZStack{
                Image(bvm.backGround.1 ? "赤":"黒")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture(){bvm.missTap()}
                    .opacity(bvm.backGround.0)
                //            ボタン１
                if bvm.btnCount >= 1{
                    Image("\(gvm.dt.animal1)\(bvm.buttonImg[0])ボタン")
                        .resizable()
                        .frame(width: w/7, height: w/7)
                        .position(x: (w/14)*CGFloat(bvm.btns.x1*2-1),
                                  y: (w/14)*CGFloat(bvm.btns.y1*2-1))
                        .onTapGesture {bvm.push(pushed: 1)}
                }
                //            ボタン２
                if bvm.btnCount >= 2{
                    Image("\(gvm.dt.animal1)\(bvm.buttonImg[1])ボタン")
                        .resizable()
                        .frame(width: w/7, height: w/7)
                        .position(x: (w/14)*CGFloat(bvm.btns.x2*2-1),
                                  y: (w/14)*CGFloat(bvm.btns.y2*2-1))
                        .onTapGesture {bvm.push(pushed: 2)}
                }
                //            ボタン３
                if bvm.btnCount == 3{
                    Image("\(gvm.dt.animal1)\(bvm.buttonImg[2])ボタン")
                        .resizable()
                        .frame(width: w/7, height: w/7)
                        .position(x: (w/14)*CGFloat(bvm.btns.x3*2-1),
                                  y: (w/14)*CGFloat(bvm.btns.y3*2-1))
                        .onTapGesture {bvm.push(pushed: 3)}
                }
                
                if gvm.dt.animal1 == "人間" {
                    Group{
                        if bvm.n >= 5{
                            Image("gボタン")
                                .resizable()
                                .onTapGesture {
                                    bvm.push(pushed: 44)
                                }
                        } else {
                            Image("gdボタン")
                                .resizable()
                        }
                    }.frame(width: 180,height: 90)
                    .position(x: w/2, y: w/1.5)
                    Text("石の数：\(bvm.n) 個")
                        .font(.title3)
                        .bold()
                        .position(x: w/2, y: w-50)
                }
            }.frame(width: w, height: w)
                .border(Color.black)
                .onAppear(){bvm.setPosition()}
            Spacer().frame(height: h/10)
        }
    }
}

struct buttonView_Previews: PreviewProvider {
    static var previews: some View {
        buttonView()
    }
}
