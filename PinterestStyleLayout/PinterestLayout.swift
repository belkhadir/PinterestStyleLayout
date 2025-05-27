//
//  PinterestLayout.swift
//  PinterestStyleLayout
//
//  Created by Belkhadir Anas on 17/5/2025.
//

import SwiftUI

struct PinterestLayout: Layout {
    
    private let numberOfColumns: Int
    private let itemSpacing: CGFloat
    
    init(numberOfColumns: Int = 2, itemSpacing: CGFloat = 12) {
        self.numberOfColumns = numberOfColumns
        self.itemSpacing = itemSpacing
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let safeProposalWidth = proposal.replacingUnspecifiedDimensions().width
        let cardWidth = (safeProposalWidth - itemSpacing) / CGFloat(numberOfColumns)
        var columnHeights = [CGFloat](repeating: 0.0, count: numberOfColumns)
        
        for (index, subView) in subviews.enumerated() {
            let height = subView.sizeThatFits(.init(width: cardWidth, height: nil)).height
            let columnIndex = index % numberOfColumns
           
            if columnHeights[columnIndex] > 0 {
                columnHeights[columnIndex] += itemSpacing
            }

            columnHeights[columnIndex] += height
        }

        return CGSize(
            width: cardWidth * CGFloat(numberOfColumns) + itemSpacing,
            height: columnHeights.max() ?? .zero // 8
        )
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let safeProposalWidth = proposal.replacingUnspecifiedDimensions().width
        let cardWidth = (safeProposalWidth - itemSpacing) / CGFloat(numberOfColumns)
        var columnHeights: [CGFloat] = .init(repeating: bounds.minY + itemSpacing, count: numberOfColumns)
        
        for (index, subView) in subviews.enumerated() {
            let columnIndex = index % numberOfColumns
            let x = bounds.minX + (cardWidth + itemSpacing) * CGFloat(columnIndex)
            
            let height = subView.sizeThatFits(.init(width: cardWidth, height: nil)).height
            let y = columnHeights[columnIndex]
            
            subView.place(
                at: CGPoint(x: x, y: y),
                proposal: ProposedViewSize(width: cardWidth, height: height)
            )
            
            columnHeights[columnIndex] += height + itemSpacing
        }
    }
}
