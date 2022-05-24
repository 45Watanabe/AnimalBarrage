//
//  ANIMAL_BALLAGEApp.swift
//  ANIMAL BALLAGE
//
//  Created by 渡辺幹 on 2022/03/03.
//

import SwiftUI
import Firebase

@main
struct ANIMAL_BALLAGEApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
