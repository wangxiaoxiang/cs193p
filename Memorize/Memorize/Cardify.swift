//
//  Cardify.swift
//  Memorize
//
//  Created by 汪潇翔 on 2022/4/4.
//

import SwiftUI

struct Cardify : ViewModifier {
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 100
    }
    
    var rotation: Double
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DarwingConstants.cornerRadius)
            if rotation < 90 {
                shape.fill().foregroundColor(DarwingConstants.fillColor)
                shape
                    .strokeBorder(lineWidth: DarwingConstants.lineWidth)
                    .foregroundColor(DarwingConstants.strokeColor)
            } else {
                shape.fill()
            }
            // 卡片内容
            content
                .opacity(rotation < 90 ? 1 : 0)
        }
    }
    
    private struct DarwingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fillColor = Color.purple
        static let strokeColor = Color.yellow
    }
    
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: true))
    }
}
