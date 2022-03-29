//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Xiaoxiao on 2022/3/30.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
