//
//  Audio.swift
//  ANIMAL BALLAGE
//
//  Created by 渡辺幹 on 2022/03/28.
//

import Foundation
import SwiftUI

class Audio {
    let sound: Sound = .sounds
    
    func playOpening(){
        switch Int.random(in: 0...5) {
        case 0: sound.opAPlay()
        case 1: sound.opBPlay()
        case 2: sound.opCPlay()
        case 3: sound.opDPlay()
        case 4: sound.opEPlay()
        case 5: sound.opFPlay()
        default:break
        }
    }
    
    func orderBattleMusic(difficulty: String) -> String{
        return playMusic(order: "\(difficulty)\(Int.random(in: 1...3))")
    }
    
    func playMusic(order: String) -> String{
        switch order {
        case "EASY1": sound.イージーbgm1Play()
        case "EASY2": sound.イージーbgm2Play()
        case "EASY3": sound.イージーbgm3Play()
        case "NORMAL1": sound.ノーマルbgm1Play()
        case "NORMAL2": sound.ノーマルbgm2Play()
        case "NORMAL3": sound.ノーマルbgm3Play()
        case "HARD1": sound.ハードbgm1Play()
        case "HARD2": sound.ハードbgm2Play()
        case "HARD3": sound.ハードbgm3Play()
        case "CRAZY1": sound.クレイジーbgm1Play()
        case "CRAZY2": sound.クレイジーbgm2Play()
        case "CRAZY3": sound.クレイジーbgm3Play()
        default: break
        }
        return order
    }
    
    func stopMusic(now: String) -> String{
        switch now {
        case "EASY1": sound.イージーbgm1Player.stop()
        case "EASY2": sound.イージーbgm2Player.stop()
        case "EASY3": sound.イージーbgm3Player.stop()
        case "NORMAL1": sound.ノーマルbgm1Player.stop()
        case "NORMAL2": sound.ノーマルbgm2Player.stop()
        case "NORMAL3": sound.ノーマルbgm3Player.stop()
        case "HARD1": sound.ハードbgm1Player.stop()
        case "HARD2": sound.ハードbgm2Player.stop()
        case "HARD3": sound.ハードbgm3Player.stop()
        case "CRAZY1": sound.クレイジーbgm1Player.stop()
        case "CRAZY2": sound.クレイジーbgm2Player.stop()
        case "CRAZY3": sound.クレイジーbgm3Player.stop()
        default: break
        }
        return ""
    }
    
    func buttonSound(animal: String){
        if animal == "リス" || animal == "梟"{
            sound.push2Play()
        } else {
            sound.push1Play()
        }
    }
    
}
