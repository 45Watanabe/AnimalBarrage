//
//  RankingView.swift
//  ANIMAL BALLAGE
//
//  Created by 渡辺幹 on 2022/03/28.
//

import SwiftUI

struct RankingView: View {
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    @ObservedObject var gvm: GameViewModel = .GVM
    let Fonts: [Font] = [.largeTitle,.title,.title2,.title3,.title3,.title3]
    var body: some View {
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
            
            ForEach(0..<5){ i in
                HStack{
                    Text("\(i+1)位")
                        .font(Fonts[i+1])
                        .fontWeight(.heavy)
                    if gvm.rankArray.count > i {
                        Text("\(gvm.rankArray[i])")
                            .font(Fonts[i])
                            .fontWeight(.heavy)
                    } else {
                        Text("まだデータがありません。")
                            .fontWeight(.heavy)
                    }
                }.frame(height: h/9)
            }
            
            
            HStack{
                ForEach(0..<5){ i in
                    changeRanking(num: i)
                }
            }
            HStack{
                ForEach(5..<8){ i in
                    changeRanking(num: i)
                }
            }
        }
    }
}

struct changeRanking: View {
    @ObservedObject var gvm: GameViewModel = .GVM
    let animalList = ["犬","猫","鳥","狼","リス","人間","駝鳥","梟"]
    let num: Int
    var body: some View {
        Button(action: {gvm.getRanking(animal: animalList[num])}){
            Image(animalList[num])
                .resizable()
                .frame(width: UIScreen.main.bounds.width/8,
                       height: UIScreen.main.bounds.width/8)
        }
    }
}

struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
        RankingView()
    }
}
