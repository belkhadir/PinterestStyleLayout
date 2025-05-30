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
        
        for subView in subviews {
            let height = subView.sizeThatFits(.init(width: cardWidth, height: nil)).height
            let columnIndex = columnHeights.enumerated().min(by: { $0.element < $1.element })!.offset
           
            if columnHeights[columnIndex] > 0 {
                columnHeights[columnIndex] += itemSpacing
            }

            columnHeights[columnIndex] += height
        }

        return CGSize(
            width: cardWidth * CGFloat(numberOfColumns) + itemSpacing,
            height: columnHeights.max() ?? .zero
        )
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let safeProposalWidth = proposal.replacingUnspecifiedDimensions().width
        let cardWidth = (safeProposalWidth - itemSpacing) / CGFloat(numberOfColumns)
        var yOffset = [CGFloat](repeating: bounds.minY, count: numberOfColumns)
        
        for subView in subviews {
            let columnIndex = yOffset.enumerated().min(by: { $0.element < $1.element })!.offset
            let x = bounds.minX + (cardWidth + itemSpacing) * CGFloat(columnIndex)
            
            let height = subView.sizeThatFits(.init(width: cardWidth, height: nil)).height
            let y = yOffset[columnIndex]
            
            subView.place(
                at: CGPoint(x: x, y: y),
                proposal: ProposedViewSize(width: cardWidth, height: height)
            )
            
            yOffset[columnIndex] += height + itemSpacing
        }
    }
}
