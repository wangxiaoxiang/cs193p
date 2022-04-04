//
//  CardView.swift
//  Memorize
//
//  Created by 汪潇翔 on 2022/4/4.
//

import SwiftUI

struct CardView : View {
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Text(card.content)
                    .padding(5)
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
        
        
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        let scale = DrawingConstants.fontSize / DrawingConstants.fontScale
        return min(size.width, size.height) / scale
    }
}


