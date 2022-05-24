//
//  Sounds.swift
//  AnimalBarrage
//
//  Created by cmStudent on 2021/11/13.
//
//      let push1Data = NSDataAsset(name: "push1")!.data
//      var push1Player: AVAudioPlayer!
//      func pushPlay() {do {
//          push1Player = try AVAudioPlayer(data: push1Data)
//          push1Player.play()
//      } catch {print("push1 エラー")}}

import UIKit
import AVFoundation

class Sound: NSObject {
    static let sounds = Sound()
    
    let push1Data = NSDataAsset(name: "push1")!.data
    var push1Player: AVAudioPlayer!
    func push1Play() {do {
        push1Player = try AVAudioPlayer(data: push1Data)
        push1Player.play()
    } catch {print("push1 エラー")}}
    
    let push2Data = NSDataAsset(name: "push2")!.data
    var push2Player: AVAudioPlayer!
    func push2Play() {do {
        push2Player = try AVAudioPlayer(data: push2Data)
        push2Player.play()
    } catch {print("push2 エラー")}}
    
    let haData = NSDataAsset(name: "ha")!.data
    var haPlayer: AVAudioPlayer!
    func haPlay() {do {
        haPlayer = try AVAudioPlayer(data: haData)
        haPlayer.play()
    } catch {print("ha エラー")}}
    
    let opAData = NSDataAsset(name: "opA")!.data
    var opAPlayer: AVAudioPlayer!
    func opAPlay() {do {
        opAPlayer = try AVAudioPlayer(data: opAData)
        opAPlayer.play()
    } catch {print("opA エラー")}}
    
    let opBData = NSDataAsset(name: "opB")!.data
    var opBPlayer: AVAudioPlayer!
    func opBPlay() {do {
        opBPlayer = try AVAudioPlayer(data: opBData)
        opBPlayer.play()
    } catch {print("opB エラー")}}
    
    let opCData = NSDataAsset(name: "opC")!.data
    var opCPlayer: AVAudioPlayer!
    func opCPlay() {do {
        opCPlayer = try AVAudioPlayer(data: opCData)
        opCPlayer.play()
    } catch {print("opC エラー")}}
    
    let opDData = NSDataAsset(name: "opD")!.data
    var opDPlayer: AVAudioPlayer!
    func opDPlay() {do {
        opDPlayer = try AVAudioPlayer(data: opDData)
        opDPlayer.play()
    } catch {print("opD エラー")}}
    
    let opEData = NSDataAsset(name: "opE")!.data
    var opEPlayer: AVAudioPlayer!
    func opEPlay() {do {
        opEPlayer = try AVAudioPlayer(data: opEData)
        opEPlayer.play()
    } catch {print("opE エラー")}}
    
    let opFData = NSDataAsset(name: "opF")!.data
    var opFPlayer: AVAudioPlayer!
    func opFPlay() {do {
        opFPlayer = try AVAudioPlayer(data: opFData)
        opFPlayer.play()
    } catch {print("opF エラー")}}
    
    let 準備bgmData = NSDataAsset(name: "準備bgm")!.data
    var 準備bgmPlayer: AVAudioPlayer!
    func 準備bgmPlay() {do {
        準備bgmPlayer = try AVAudioPlayer(data: 準備bgmData)
        準備bgmPlayer.play()
    } catch {print("準備bgm エラー")}}
    
    let イージーbgm1Data = NSDataAsset(name: "イージーbgm1")!.data
    var イージーbgm1Player: AVAudioPlayer!
    func イージーbgm1Play() {do {
        イージーbgm1Player = try AVAudioPlayer(data: イージーbgm1Data)
        イージーbgm1Player.play()
    } catch {print("イージーbgm1 エラー")}}
    
    let イージーbgm2Data = NSDataAsset(name: "イージーbgm2")!.data
    var イージーbgm2Player: AVAudioPlayer!
    func イージーbgm2Play() {do {
        イージーbgm2Player = try AVAudioPlayer(data: イージーbgm2Data)
        イージーbgm2Player.play()
    } catch {print("イージーbgm2 エラー")}}
    
    let イージーbgm3Data = NSDataAsset(name: "イージーbgm3")!.data
    var イージーbgm3Player: AVAudioPlayer!
    func イージーbgm3Play() {do {
        イージーbgm3Player = try AVAudioPlayer(data: イージーbgm3Data)
        イージーbgm3Player.play()
    } catch {print("イージーbgm3 エラー")}}
    
    let ノーマルbgm1Data = NSDataAsset(name: "ノーマルbgm1")!.data
    var ノーマルbgm1Player: AVAudioPlayer!
    func ノーマルbgm1Play() {do {
        ノーマルbgm1Player = try AVAudioPlayer(data: ノーマルbgm1Data)
        ノーマルbgm1Player.play()
    } catch {print("ノーマルbgm1 エラー")}}
    
    let ノーマルbgm2Data = NSDataAsset(name: "ノーマルbgm2")!.data
    var ノーマルbgm2Player: AVAudioPlayer!
    func ノーマルbgm2Play() {do {
        ノーマルbgm2Player = try AVAudioPlayer(data: ノーマルbgm2Data)
        ノーマルbgm2Player.play()
    } catch {print("ノーマルbgm2 エラー")}}
    
    let ノーマルbgm3Data = NSDataAsset(name: "ノーマルbgm3")!.data
    var ノーマルbgm3Player: AVAudioPlayer!
    func ノーマルbgm3Play() {do {
        ノーマルbgm3Player = try AVAudioPlayer(data: ノーマルbgm3Data)
        ノーマルbgm3Player.play()
    } catch {print("ノーマルbgm3 エラー")}}
    
    let ハードbgm1Data = NSDataAsset(name: "ハードbgm1")!.data
    var ハードbgm1Player: AVAudioPlayer!
    func ハードbgm1Play() {do {
        ハードbgm1Player = try AVAudioPlayer(data: ハードbgm1Data)
        ハードbgm1Player.play()
    } catch {print("ハードbgm1 エラー")}}
    
    let ハードbgm2Data = NSDataAsset(name: "ハードbgm2")!.data
    var ハードbgm2Player: AVAudioPlayer!
    func ハードbgm2Play() {do {
        ハードbgm2Player = try AVAudioPlayer(data: ハードbgm2Data)
        ハードbgm2Player.play()
    } catch {print("ハードbgm2 エラー")}}
    
    let ハードbgm3Data = NSDataAsset(name: "ハードbgm3")!.data
    var ハードbgm3Player: AVAudioPlayer!
    func ハードbgm3Play() {do {
        ハードbgm3Player = try AVAudioPlayer(data: ハードbgm3Data)
        ハードbgm3Player.play()
    } catch {print("ハードbgm3 エラー")}}
    
    let クレイジーbgm1Data = NSDataAsset(name: "クレイジーbgm1")!.data
    var クレイジーbgm1Player: AVAudioPlayer!
    func クレイジーbgm1Play() {do {
        クレイジーbgm1Player = try AVAudioPlayer(data: クレイジーbgm1Data)
        クレイジーbgm1Player.play()
    } catch {print("クレイジーbgm1 エラー")}}
    
    let クレイジーbgm2Data = NSDataAsset(name: "クレイジーbgm2")!.data
    var クレイジーbgm2Player: AVAudioPlayer!
    func クレイジーbgm2Play() {do {
        クレイジーbgm2Player = try AVAudioPlayer(data: クレイジーbgm2Data)
        クレイジーbgm2Player.play()
    } catch {print("クレイジーbgm2 エラー")}}
    
    let クレイジーbgm3Data = NSDataAsset(name: "クレイジーbgm3")!.data
    var クレイジーbgm3Player: AVAudioPlayer!
    func クレイジーbgm3Play() {do {
        クレイジーbgm3Player = try AVAudioPlayer(data: クレイジーbgm3Data)
        クレイジーbgm3Player.play() 
    } catch {print("クレイジーbgm3 エラー")}}
}
