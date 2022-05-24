//
//  SearchRoomView.swift
//  ANIMAL BALLAGE
//
//  Created by 渡辺幹 on 2022/04/13.
//

import SwiftUI

struct SearchRoomView: View {
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    @ObservedObject var gvm: GameViewModel = .GVM
    let color: [Color] = [.yellow,.green,.red,.black]
    let difficultyList = ["EASY","NORMAL","HARD","CRAZY"]
    var body: some View {
        ZStack{
            
            VStack(spacing: w/6){
                Text("\(gvm.dt.name1)")
                    .font(.largeTitle)
                ZStack{
                    Image("frame")
                        .resizable()
                        .frame(width: w/2.3, height: w/2.3)
                    Image("\(gvm.dt.animal1)")
                        .resizable()
                        .frame(width: w/2.5, height: w/2.5)
                }
                HStack{
                    ForEach(0..<4){ i in
                        if gvm.dt.difficulty == difficultyList[i] {
                            Text("\(gvm.dt.difficulty)")
                                .font(.system(.title, design: .serif))
                                .foregroundColor(color[i])
                                
                        }
                    }
                    Text("\(gvm.dt.gameTime)秒")
                        .font(.title)
                }
                VStack(spacing: 1){
                    Text("あ　　い　　こ　　と　　ば")
                        .font(.caption)
                    TextField("合言葉", text: $gvm.dt.roomPass)
                        .font(.title)
                        .frame(width: w/2, height: w/8)
                        .background(Color.white)
                        .border(Color.black)
                }
                
                HStack{
                    Button(action: {
                        FirebaseModel.FbM.waitPlayer(userId: gvm.dt.player1Id,
                                                     roomPass: gvm.dt.roomPass)
                        gvm.select = "matchNow"
                    }){
                        Text("待つ")
                            .font(.title)
                            .frame(width: w/4, height: w/4)
                            .background(Color.gray)
                    }
                    Spacer().frame(width: w*0.2)
                    Button(action: {
                        FirebaseModel.FbM.searchPlayer(userId: gvm.dt.player1Id,
                                                     roomPass: gvm.dt.roomPass)
                        gvm.select = "matchNow"
                    }){
                        Text("探す")
                            .font(.title)
                            .frame(width: w/4, height: w/4)
                            .background(Color.gray)
                    }
                }
                
            }
            
            if gvm.select == "matchNow" {
                loadingView()
            } else {
                VStack{
                    HStack{
                        Button(action: {
                            gvm.changeMode(Mode: "home")
                            gvm.resetAll()
                        }){
                            Image(systemName: "house.circle")
                                .resizable()
                                .frame(width: w/10, height: w/10)
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct loadingView: View {
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    @ObservedObject var gvm: GameViewModel = .GVM
    var body: some View {
        ZStack{
            Button(action: {}){
                Image("Brack")
                    .resizable()
                    .frame(width: w, height: h*0.9)
                    .opacity(0.8)
            }
            VStack{
                HStack{
                    Spacer()
                    Button(action: {gvm.select = ""}){
                        Text("X").font(.title)
                            .foregroundColor(Color.white)
                    }
                }
                Spacer()
                Text("あ い こ と ば")
                    .foregroundColor(Color.white)
                Text("\(gvm.dt.roomPass)")
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Spacer()
                Text("待機中")
                    .font(.system(size: 60,weight: .bold, design: .rounded))
                    .foregroundColor(Color.white)
                Spacer().frame(height: h/10)
            }
        }
    }
}

struct SearchRoomView_Previews: PreviewProvider {
    static var previews: some View {
        loadingView()
    }
}
