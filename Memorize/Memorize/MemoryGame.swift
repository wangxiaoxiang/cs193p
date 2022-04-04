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
    
    // 当前翻面的卡片
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter { index in
                cards[index].isFaceUp
            }.oneAndOnly
        }
        set {
            cards.indices.forEach { index in
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
            if let potantialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potantialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potantialMatchIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    /// 打乱数据
    mutating func shuffle(){
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        
        // Identifiable protocol
        let id: Int
        let content: CardContent
        
        var isFaceUp = false {
            didSet {
                // TODO: xx
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        
        var bonusTimeLimit: TimeInterval = 6
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRamaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isCounsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime(){
            if isCounsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime(){
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
        
    }
}

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
