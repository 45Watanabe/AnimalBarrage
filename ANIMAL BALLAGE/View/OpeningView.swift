//
//  OpeningView.swift
//  ANIMAL BALLAGE
//
//  Created by 渡辺幹 on 2022/03/03.
//

import SwiftUI

struct OpeningView: View {
    @ObservedObject var gvm: GameViewModel = .GVM
    @State var startButton = false
    @State var dept = 0.0
    let audio = Audio()
    var body: some View {
        ZStack{
//            ロゴ
            VStack{
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
//            startボタン
            VStack{
                Spacer()
                if startButton {
                    Button(action: {
                        gvm.changeMode(Mode: "home")
                        gvm.backGround = gvm.dt.difficulty
                    }) {
                        Image("STARTボタン")
                            .resizable()
                            .frame(width: 130, height: 70)
                    }
                }
                Spacer().frame(height: 100)
            }
        }.onAppear(){open();audio.playOpening()}
    }
    
    func open() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            dept += 0.05
            if dept >= 1.0{
                startButton = true
            } else {
                open()
            }
        }
    }
}

struct OpeningView_Previews: PreviewProvider {
    static var previews: some View {
        OpeningView()
    }
}
