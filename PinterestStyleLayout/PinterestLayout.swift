//
//  PinterestLayout.swift
//  PinterestStyleLayout
//
//  Created by Belkhadir Anas on 17/5/2025.
//

import SwiftUI

struct PinterestLayout<Content: View>: View {
    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        VStack {
            content()
        }
    }
}
