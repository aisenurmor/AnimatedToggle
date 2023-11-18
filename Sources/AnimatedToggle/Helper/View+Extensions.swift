//
//  View+Extensions.swift
//
//
//  Created by Aise Nur Mor on 15.11.2023.
//

import SwiftUI

extension View {
    
    func addBorder<S>(
        _ content: S,
        width: CGFloat = 1,
        cornerRadius: CGFloat
    ) -> some View where S : ShapeStyle {
        
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
        return clipShape(roundedRect)
            .overlay(
                roundedRect.strokeBorder(content, lineWidth: width)
            )
    }
}
