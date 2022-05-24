//
//  LogView.swift
//  ANIMAL BALLAGE
//
//  Created by 渡辺幹 on 2022/03/28.
//

import SwiftUI

struct LogView: View {
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    @ObservedObject var gvm: GameViewModel = .GVM
    var body: some View {
        ZStack{
            VStack{
                Button(action: {
                    gvm.changeMode(Mode: "home")
                    gvm.backGround = gvm.dt.difficulty
                }){
                    Image(systemName: "house.circle")
                        .resizable()
                        .frame(width: w/10, height: w/10)
                        .foregroundColor(.black)
                }
                ForEach(0..<6){ i in
                    if gvm.logArray.count > i {
                        logBrock(num: i)
                    } else {
                        dataEmpty(num: i)
                    }
                }
            }
        }
    }
}

struct logBrock: View {
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    let num: Int
    @ObservedObject var gvm: GameViewModel = .GVM
    var body: some View {
        HStack{
            VStack{
                Text(gvm.logArray[num][0])
                Image(gvm.logArray[num][1])
                    .resizable()
                    .frame(width: w/10, height: w/10)
                Text(gvm.logArray[num][2])
            }
            VStack{
                Text(gvm.logArray[num][3])
                Image(gvm.logArray[num][4])
                    .resizable()
                    .frame(width: w/10, height: w/10)
                Text(gvm.logArray[num][5])
            }
            VStack{
                Text("\(num)回前")
                HStack{
                    Text(gvm.logArray[num][6])
                    Text(gvm.logArray[num][7])
                }
                if gvm.logArray[num][8] == "0" {
                    Text("勝ち")
                        .font(.title).foregroundColor(Color.red)
                } else if gvm.logArray[num][8] == "1" {
                    Text("引き分け")
                        .font(.title).foregroundColor(Color.gray)
                } else if gvm.logArray[num][8] == "2" {
                    Text("負け")
                        .font(.title).foregroundColor(Color.blue)
                }
            }
        }.frame(width: w*0.8, height: h/8)
            .border(Color.black)
            .background(Color.white)
    }
}

struct dataEmpty: View {
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    let num: Int
    var body: some View {
        VStack{
            Text("\(num)回前のデータがありません")
                .font(.title3)
            Text("もっと遊びましょう！")
                .font(.title)
        }.frame(width: w*0.95, height: h/8)
            .border(Color.black)
            .background(Color.white)
    }
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView()
    }
}
