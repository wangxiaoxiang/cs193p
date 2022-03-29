//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Xiaoxiao on 2022/3/30.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    private static let game = EmojiMemoryGame()
    static var previews: some View {
        EmojiMemoryGameView(game: game)
    }
}
