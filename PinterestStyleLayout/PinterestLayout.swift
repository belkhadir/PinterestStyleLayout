//
//  PinterestLayout.swift
//  PinterestStyleLayout
//
//  Created by Belkhadir Anas on 17/5/2025.
//

import SwiftUI

struct PinterestLayout: Layout {
    
    private static let numberOfColumns: Int = 2
    private let itemSpacing: CGFloat
    
    init(itemSpacing: CGFloat = 12) {
        self.itemSpacing = itemSpacing
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let safeProposalWidth = proposal.replacingUnspecifiedDimensions().width
        let cardWidth = (safeProposalWidth - itemSpacing) / CGFloat(Self.numberOfColumns)

        var leftSizeColumns: [CGFloat] = []
        var righSizeColumns: [CGFloat] = []
                
        for (index, subView) in subviews.enumerated() {
            let height = subView.sizeThatFits(.init(width: cardWidth, height: nil)).height
            if isNewLine(index: index) {
                righSizeColumns.append(height)
            } else {
                leftSizeColumns.append(height)
            }
        }
        
        let totalHeight = max(
            totalHeight(for: leftSizeColumns),
            totalHeight(for: righSizeColumns)
        )
        
        return CGSize(
            width: cardWidth * CGFloat(Self.numberOfColumns) + itemSpacing,
            height: totalHeight + itemSpacing
        )
    }
    
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let safeProposalWidth = proposal.replacingUnspecifiedDimensions().width
        let cardWidth = (safeProposalWidth - itemSpacing) / CGFloat(Self.numberOfColumns)
        
        var leftSizeColumns: [LayoutSubviews.Element] = []
        var righSizeColumns: [LayoutSubviews.Element] = []
        
        for (index, subView) in subviews.enumerated() {
            if isNewLine(index: index) {
                righSizeColumns.append(subView)
            } else {
                leftSizeColumns.append(subView)
            }
        }
        
        var x = bounds.minX
        var y = bounds.minY + itemSpacing
        
        for leftSizeColumn in leftSizeColumns {
            let height = leftSizeColumn.sizeThatFits(.init(width: cardWidth, height: nil)).height
            leftSizeColumn.place(
                at: CGPoint(x: x, y: y),
                proposal: ProposedViewSize(
                    width: cardWidth,
                    height: height
                )
            )
            
            y += itemSpacing + height
        }
        
        // TODO: Now it's your turn! Using the same logic as the left column,
        // calculate the x position for the right column (after the left column + spacing),
        // reset y to the top, and place each right-side view accordingly.
    }
}

// MARK: - Helpers
private extension PinterestLayout {
    func isNewLine(index: Int) -> Bool {
        (index % Self.numberOfColumns) == (Self.numberOfColumns - 1)
    }
    
    func totalHeight(for heights: [CGFloat]) -> CGFloat {
        guard !heights.isEmpty else { return 0 }
        return heights.reduce(0, +) + itemSpacing * CGFloat(heights.count - 1)
    }
}

