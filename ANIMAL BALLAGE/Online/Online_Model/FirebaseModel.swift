//
//  FirebaseModel.swift
//  ANIMAL BALLAGE
//
//  Created by 渡辺幹 on 2022/04/13.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import Combine
import SwiftUI

class FirebaseModel: ObservableObject {
    static let FbM = FirebaseModel()
    init() {}
    
    var md: GameViewModel = .GVM
    @Published var game: Game!
    
    func startOnlineBattle() {
        getAllData()
        md.changeMode(Mode: "checkOnline")
        md.isOnline = true
        md.select = ""
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.md.changeMode(Mode: "battle")
            self.md.startCount()
        }
    }
    
    func waitPlayer(userId: String, roomPass: String) {
        // ルームを探す
        FirebaseReference(.Game)
            .whereField("player1Id", isEqualTo: userId)
            .getDocuments { querySnapShot, error in
                if error != nil {
                    print("Error starting game", error?.localizedDescription)
                    return
                }
                self.createRoom(userId: userId, roomPass: roomPass)
                self.detectionInRoom(userId: userId, roomPass: roomPass)
            }
    }
    
    func searchPlayer(userId: String, roomPass: String) {
        // roomPassで探す。(自分の部屋でなく、player2もいない)
        FirebaseReference(.Game)
            .whereField("roomPass", isEqualTo: roomPass)
            .whereField("player1Id", isNotEqualTo: userId)
            .whereField("player2Id", isEqualTo: "")
            .getDocuments { querySnapShot, error in
            
            if error != nil {
                print("Error starting game", error?.localizedDescription)
                // 0.5秒毎に検索をかける
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if self.md.select=="matchNow"{self.searchPlayer(userId: userId, roomPass: roomPass)}
                }
                
            }
            // 相手のデータを取得、player2にデータを登録、Firebaseに変更をかける
            if let gameData = querySnapShot?.documents.first {
                self.game = try! gameData.data(as: Game.self)
                self.inTheRoom(userId: userId, roomId: self.game.player1Id)
                self.startOnlineBattle()
            }
        }
    }
    
    func detectionInRoom(userId: String, roomPass: String) {
        FirebaseReference(.Game)
            .whereField("player1Id", isEqualTo: userId)
            .whereField("roomPass", isEqualTo: roomPass)
        
            .getDocuments { querySnapShot, error in
                // 部屋がなかった場合
                if error != nil {
                    print("Error starting game", error?.localizedDescription)
                    // 0.5秒まいにリサーチ
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        if self.md.select=="matchNow"{self.detectionInRoom(userId: userId, roomPass: roomPass)}
                    }
                    return
                }
                
                // 部屋がある場合
                if let gameData = querySnapShot?.documents.first{
                    self.game = try! gameData.data(as: Game.self)
                    // player2がいた/いなかった
                    if self.game.player2Id != "" {
                        self.startOnlineBattle()
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.detectionInRoom(userId: userId, roomPass: roomPass)
                        }
                    }
                }
            }
    }

    
    func createRoom(userId: String, roomPass: String) {
        print("----------createData")
        // md.dtの情報を基にGame型にデータを格納
        self.game = Game(roomPass: roomPass,
                         player1Id: userId, player2Id: "",
                         name1: md.dt.name1, animal1: md.dt.animal1,
                         score1: 0, tap1: 0, miss1: 0,
                         difficulty1: md.dt.difficulty, gameTime1: md.dt.gameTime,
                         name2: "", animal2: "",
                         score2: 0, tap2: 0, miss2: 0,
                         difficulty2: "", gameTime2: 0,
                         result: 1)
        saveOnline(userId: userId)
    }
    
    func inTheRoom(userId: String, roomId: String) {
        // gameに自分のデータをplayer2に登録
        self.game.player2Id = userId
        self.game.name2 = self.md.dt.name1
        self.game.animal2 = self.md.dt.animal1
        self.game.difficulty2 = self.md.dt.difficulty
        self.game.gameTime2 = self.md.dt.gameTime
        
        saveOnline(userId: roomId)
    }
    
    func saveOnline(userId: String) {
        print("playerId1の部屋にデータの登録")
        do {
            try FirebaseReference(.Game)
                .document(userId)
                .setData(from: self.game)
        } catch {
            print("Error creating online game", error.localizedDescription)
        }
    }
    
    func setMyScore() {
        if game.name1 == md.dt.name1 {
            FirebaseReference(.Game)
                .document(game.player1Id)
                .setData(["score1": md.dt.score1],merge: true)
        } else {
            FirebaseReference(.Game)
                .document(game.player1Id)
                .setData(["score2": md.dt.score1],merge: true)
        }
    }
    
    func getEnemyScore() {
        FirebaseReference(.Game)
            .document(game.player1Id)
            .getDocument{(snap, error) in
                if let error = error {fatalError("\(error)")}
                guard let data = snap?.data() else {return}
                if let snapshot = snap {
                    self.game = try? snapshot.data(as: Game.self)
                }
                if self.game.name1 == self.md.dt.name1 {
                    self.md.dt.score2 = self.game.score2
                } else {
                    self.md.dt.score2 = self.game.score1
                }
            }
    }
    
    func getAllData() {
        if game.player1Id == md.dt.player1Id {
            FirebaseReference(.Game)
                .document(game.player1Id)
                .getDocument{(snap, error) in
                    if let error = error {fatalError("\(error)")}
                    guard let data = snap?.data() else {return}
                    self.md.dt.name2 = self.game.name2
                    self.md.dt.animal2 = self.game.animal2
                    self.md.dt.difficulty2 = self.game.difficulty2
                    self.md.dt.score2 = self.game.score2
                    self.md.dt.tap2 = self.game.tap2
                    self.md.dt.miss2 = self.game.miss2
                }
        } else {
            FirebaseReference(.Game)
                .document(game.player1Id)
                .getDocument{(snap, error) in
                    if let error = error {fatalError("\(error)")}
                    guard let data = snap?.data() else {return}
                    self.md.dt.name2 = self.game.name1
                    self.md.dt.animal2 = self.game.animal1
                    self.md.dt.difficulty2 = self.game.difficulty1
                    self.md.dt.score2 = self.game.score1
                    self.md.dt.tap2 = self.game.tap1
                    self.md.dt.miss2 = self.game.miss1
                }
        }
    }
}

struct Game: Codable {
    var roomPass: String
    var player1Id: String
    var player2Id: String
    
    var name1: String
    var animal1: String
    var score1: Int
    var tap1: Int
    var miss1: Int
    var difficulty1: String
    var gameTime1: Int
    
    var name2: String
    var animal2: String
    var score2: Int
    var tap2: Int
    var miss2: Int
    var difficulty2: String
    var gameTime2: Int
    
    var result: Int
}
