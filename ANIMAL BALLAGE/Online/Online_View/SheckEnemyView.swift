//
//  SheckEnemyView.swift
//  ANIMAL BALLAGE
//
//  Created by 渡辺幹 on 2022/04/13.
//

import SwiftUI

struct SheckEnemyView: View {
    @ObservedObject var gvm: GameViewModel = .GVM
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    let color: [Color] = [.yellow,.green,.red,.black]
    let difficultyList = ["EASY","NORMAL","HARD","CRAZY"]
    @ObservedObject var fvm: FirebaseModel = .FbM
    var body: some View {
        ZStack{
            ZStack{
                VStack{
                    HStack{
                        VStack{
                            Text("\(gvm.dt.name1)")
                                .font(.title)
                            Image("\(gvm.dt.animal1)")
                                .resizable()
                                .frame(width: w/3, height: w/3)
                            ForEach(0..<4){ i in
                                if gvm.dt.difficulty == difficultyList[i] {
                                    Text("\(gvm.dt.difficulty)")
                                        .font(.system(.title, design: .serif))
                                        .foregroundColor(color[i])
                                        
                                }
                            }
                        }
                        Image("VS")
                            .resizable()
                            .frame(width: w/7, height: w/7)
                        VStack{
                            Text("\(gvm.dt.name2)")
                                .font(.title)
                            Image("\(gvm.dt.animal2)")
                                .resizable()
                                .frame(width: w/3, height: w/3)
                            ForEach(0..<4){ i in
                                if gvm.dt.difficulty2 == difficultyList[i] {
                                    Text("\(gvm.dt.difficulty2)")
                                        .font(.system(.title, design: .serif))
                                        .foregroundColor(color[i])
                                        
                                }
                            }
                        }
                    }
                    Spacer().frame(height: h/5)
                    Text("30秒")
                        .font(.largeTitle)
                }
            }
        }
    }
}

struct SheckEnemyView_Previews: PreviewProvider {
    static var previews: some View {
        SheckEnemyView()
    }
}
