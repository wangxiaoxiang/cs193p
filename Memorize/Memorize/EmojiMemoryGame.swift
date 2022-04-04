//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Xiaoxiao on 2022/3/30.
//

import Foundation

class EmojiMemoryGame : ObservableObject {
    
    typealias Card = MemoryGame<String>.Card
    
    private static let emojis = ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️","🛸","🛶","🚌","🏍","🛺","🚡","🛵","🚗","🚚","🚇","🚙","🚈"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 8) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<Card> {
        model.cards
    }
    
    public func choose(_ card: Card) {

    }
    
    public func shuffle(){
        
    }
    
    public func restart(){
        
    }
}
