//
//  MemoryGame.swift
//  Memorize
//
//  Created by 汪潇翔 on 2022/3/31.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private (set) var cards:[Card]
    
    init(numberOfPairsOfCards: Int,
         createCardContent: (Int/* pairIndex */) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            let card1 = Card(id: pairIndex * 2, content: content)
            let card2 = Card(id: pairIndex * 2 + 1, content: content)
            cards.append(card1)
            cards.append(card2)
        }
        
        // 打乱数据
        shuffle()
    }
    
    
    /// 打乱数据
    mutating func shuffle(){
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        
        // Identifiable protocol
        let id: Int
        let content: CardContent
        
    }
}
