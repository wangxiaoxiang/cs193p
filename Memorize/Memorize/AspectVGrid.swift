//
//  AspectVGrid.swift
//  Memorize
//
//  Created by 汪潇翔 on 2022/3/31.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    var items:[Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                let width  = widthThatFits(in: geometry.size)
                LazyVGrid(columns: [adaptiveGridItem(width: width)]) {
                    ForEach(items) { item in
                        content(item).aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
                Spacer(minLength: 0)
            }
        }
    }
    
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        let gridItem = GridItem(.adaptive(minimum: width), spacing: 0)
        
        return gridItem
    }
    
    /// 计算每一行的列数，返回每个 item 的宽度
    /// - Parameters:
    ///   - itemCount: item 总数
    ///   - size: 容器大小
    ///   - aspectRatio: 比例
    /// - Returns:  item 的宽度
    private func widthThatFits(in size: CGSize) -> CGFloat {
        let itemCount = items.count
        var columnCount = 1
        var rowCount = itemCount
        
        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / aspectRatio
            // 超过容器大小
            if CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
        } while columnCount < itemCount
        
        if columnCount > itemCount {
            columnCount = itemCount
        }
        return floor(size.width / CGFloat(columnCount))
    }
}

//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}
