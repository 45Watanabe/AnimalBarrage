//
//  Model.swift
//  ANIMAL BALLAGE
//
//  Created by 渡辺幹 on 2022/03/05.
//

import Foundation
import SwiftUI

struct data {
    var roomPass = ""
    var roomId = ""
    @AppStorage("userId") var player1Id = ""
    var player2Id = ""
    @AppStorage("userName") var name1 = "無名"
    var animal1 = "犬"
    var score1 = 0
    var tap1 = 0
    var miss1 = 0
    
    var name2 = "CPU"
    var animal2 = "猫"
    var score2 = 0
    var tap2 = 0
    var miss2 = 0
    
    var difficulty = "NORMAL"
    var difficulty2 = "NORMAL"
    var gameTime = 30
    
    var result = 1 // 0:勝 1:引き分け 2:負け
    
    var escap1 = false
    var escape2 = false
}

class GameViewModel: ObservableObject {
    private init(){
        if dt.player1Id == "" {
            dt.player1Id = UUID().uuidString
        }
    }
    static let GVM = GameViewModel()
    let audio = Audio()
    @Published var nowBGM = ""
    @Published var mode = "title"
    @Published var backGround = "TITLE\(Int.random(in: 1...5))"
    
    @Published var dt = data()
    @Published var select = ""
    @Published var isOnline = false
    
    @AppStorage("eggCount") var eggCount = 100000
    @Published var logArray: [[String]] = []
    @Published var rankArray: [Int] = []
    
    func changeMode(Mode: String) {
        mode = Mode
    }
    
    let enemyList = ["猫","狼","獅子","人間","子猫"]
    var enemyNum = 0
    func changeEnemy(){
        if enemyNum == enemyList.count-1 {enemyNum = 0}
        else {enemyNum += 1}
        dt.animal2 = enemyList[enemyNum]
    }
    
    func resetAll() {
        dt.name2 = "CPU"; dt.animal2 = "猫";
        dt.score1 = 0; dt.tap1 = 0; dt.miss1 = 0
        dt.score2 = 0; dt.tap2 = 0; dt.miss2 = 0
        dt.escap1 = false; dt.escape2 = false
        dt.difficulty2 = "NORMAL"
        three = 3
        isOnline = false
    }
    
    
    @Published var gameCounter : Timer?
    @Published var three = 3
    @Published var count = 30
    // 開始前の三秒カウント + ゲーム時間のカウント
    func startCount(){
        nowBGM = audio.orderBattleMusic(difficulty: dt.difficulty)
        count = dt.gameTime
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.updateScore()
        }
        gameCounter = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ _ in
            if self.three > 0 { self.three -= 1 } else { self.count -= 1 }
            if self.count == 0 { self.gameCounter?.invalidate() }
        }
    }
    
    func updateScore() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if self.isOnline {
                FirebaseModel.FbM.getEnemyScore()
                FirebaseModel.FbM.setMyScore()
            } else {
                self.addEnemyScore()
            }
            if self.count >= 1 {
                self.updateScore()
            }
        }
    }
    
    func addEnemyScore(){
        dt.tap2 += Int.random(in: 1...2)
        let i = Int.random(in: 0...5)
        if i < 5 {
            if dt.name2 == "CPU" {
                switch dt.animal2 {
                case "猫": dt.score2 += Int.random(in: 1...10)
                case "狼": dt.score2 += Int.random(in: 3...10)
                case "獅子": dt.score2 += Int.random(in: 6...10)
                case "人間": dt.score2 += Int.random(in: 10...15)
                case "子猫": dt.score2 += Int.random(in: 15...20)
                default: break
                }
            }
        } else {
            dt.miss2 += 1
            if dt.difficulty == "HARD" ||
                dt.difficulty == "CRAZY" {
                dt.score1 -= 5
            }
        }
    }
    
    func finishGame() {
        if isOnline {
            FirebaseModel.FbM.getEnemyScore()
        }
        var score = dt.score1
        if dt.difficulty == "EASY" {score*=2}
        var score2 = dt.score2
        if dt.difficulty2 == "EASY" {score2*=2}
        
        if score - score2 > 0 {
            dt.result = 0
        } else if score - score2 == 0 {
            dt.result = 1
        } else if score - score2 < 0 {
            dt.result = 2
        }
        
        let thisTimeData = ["\(dt.score1)", dt.animal1, dt.name1,
                            "\(dt.score2)", dt.animal2, dt.name2,
                            dt.difficulty, "\(dt.gameTime)秒", "\(dt.result)"]
        updateLog(newData: thisTimeData)
        
        updateRanking(animal: dt.animal1, newScore: dt.score1)
        if isOnline {
            updateRanking(animal: dt.animal2, newScore: dt.score2)
        }
    }
    
    func getlog() {
        // logの取得、代入
        if let log = UserDefaults.standard.array(forKey: "logArray") as? [[String]] {
            logArray = log
        }
        print("logの数")
        print(logArray.count)
    }
    
    func updateLog(newData: [String]) {
        getlog()
        logArray.append(newData)
        if logArray.count > 5 {logArray.remove(at: 0)}
        UserDefaults.standard.setValue(logArray, forKey: "logAray")
    }
    
    func getRanking(animal: String) {
        // rankingの取得、代入
        if let ranking = UserDefaults.standard.array(forKey: "\(animal)ranking") as? [Int]{
            rankArray = ranking
        }
    }
    func updateRanking(animal: String, newScore: Int) {
        getRanking(animal: animal)
        rankArray.append(newScore)
        rankArray.sort{$0 > $1}
        if rankArray.count > 5 {rankArray.removeLast()}
        UserDefaults.standard.setValue(rankArray, forKey: "\(animal)ranking")
    }
}
