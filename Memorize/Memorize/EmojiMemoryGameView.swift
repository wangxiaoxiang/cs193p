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
        gameBody
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill()
                    .foregroundColor(.brown)
                Text(card.content)
            }
        }
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    private static let game = EmojiMemoryGame()
    static var previews: some View {
        EmojiMemoryGameView(game: game)
    }
}
