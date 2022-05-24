//
//  ContentView.swift
//  ANIMAL BALLAGE
//
//  Created by 渡辺幹 on 2022/03/03.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var gvm: GameViewModel = .GVM
    var body: some View {
        // if文で画面の遷移
        ZStack{
            Image(gvm.backGround)
                .resizable()
                .edgesIgnoringSafeArea(.all)
            if gvm.mode == "title" {
                OpeningView()
            } else if gvm.mode == "home" {
                HomeView()
            } else if gvm.mode == "battle" {
                BattleView()
            } else if gvm.mode == "result" {
                ResultView()
            } else if gvm.mode == "special" {
                SpacialView()
            } else if gvm.mode == "log" {
                LogView()
            } else if gvm.mode == "ranking" {
                RankingView()
            } else if gvm.mode == "matching" {
                SearchRoomView()
            } else if gvm.mode == "checkOnline" {
                SheckEnemyView()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
