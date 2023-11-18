//
//  AnimatedToggle.swift
//
//
//  Created by Aise Nur Mor on 15.11.2023.
//

import SwiftUI

public typealias TapAction = (Bool) -> Void

public struct AnimatedToggle: View {
    
    @ObservedObject
    private var storage: AnimatedToggleStorage
    
    private var state: ToggleState { storage.state }
    
    private var width: CGFloat { state.rawValue ? settings.size.height*0.2 : settings.size.height*0.5 }
    private var height: CGFloat { state.rawValue ? settings.size.height*0.64 : width }
    private var strokeWidth: CGFloat { state.rawValue ? 0 : height*0.3 }
    private var cornerRadius: CGFloat { state.rawValue ? 14 : height/2 }
    
    private let settings: Settings
    private let onTapAction: TapAction
    
    public init(
        isOn: Bool = false,
        settings: Settings = .init(),
        onTapAction: @escaping TapAction = { _ in }
    ) {
        self.storage = .init(
            states: [
                .on: ToggleState.on.style,
                .off: ToggleState.off.style
            ],
            state: ToggleState(rawValue: isOn)
        )
        self.settings = settings
        self.onTapAction = onTapAction
    }
    
    public var body: some View {
        ZStack(alignment: state.alignment) {
            Capsule()
                .apply(background: storage)
                .frame(width: settings.size.width, height: settings.size.height)
                .apply(shadow: storage)
            
            RoundedRectangle(cornerRadius: cornerRadius, style: .circular)
                .fill(state.rawValue ? .white : .clear)
                .frame(width: width, height: height)
                .addBorder(
                    .white,
                    width: strokeWidth,
                    cornerRadius: cornerRadius
                )
                .background(.clear)
                .padding(.vertical, 0)
                .padding(.leading, width*0.6)
                .padding(.trailing, width*1.4)
                .scaleEffect(1, anchor: .trailing)
                .animation(
                    .interpolatingSpring(stiffness: 140, damping: 16).delay(0.1),
                    value: state.rawValue
                )
        }
        .onTapGesture {
            withAnimation(.spring()) {
                storage.state.toggle()
                onTapAction(storage.state.rawValue)
            }
        }
    }
}

public extension AnimatedToggle {
    
    func editing(
        on: ToggleStateItem,
        off: ToggleStateItem
    ) -> Self {
        return editing(states: [.on: on, .off: off])
    }
    
    private func editing(
        states: [ToggleState: ToggleStateItem]
    ) -> Self {
        self.storage.states = self.storage.states.editing(with: states)
        return self
    }
}

public extension AnimatedToggle {
    
    struct Settings {
        let size: CGSize
        
        public init(height: CGFloat = 50) {
            self.size = .init(width: height*1.85, height: height)
        }
    }
}

private extension Dictionary where Key == ToggleState, Value == ToggleStateItem {
    
    func editing(with states: Self) -> Self {
        var result = self
        for item in states {
            result[item.key] = result[item.key].editing(with: item.value)
        }
        return result
    }
}

private extension Optional where Wrapped == ToggleStateItem {
    
    func editing(with item: Wrapped) -> Wrapped {
        switch self {
        case .none:
            return item
        case .some(let wrapped):
            return wrapped.editing(with: item)
        }
    }
}

private extension Shape {
    
    @ViewBuilder
    func apply(background
        storage: AnimatedToggleStorage
    ) -> some View {
        self.fill(storage[\.backgroundColor]!)
    }
}

private extension View {
    
    @ViewBuilder
    func apply(shadow
        storage: AnimatedToggleStorage
    ) -> some View {
        self.shadow(color: storage[\.shadowColor]!, radius: 8)
    }
}

#if DEBUG
#Preview {
    AnimatedToggle()
}
#endif
