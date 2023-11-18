//
//  AnimatedToggleStorage.swift
//
//
//  Created by Aise Nur Mor on 16.11.2023.
//

import SwiftUI

final class AnimatedToggleStorage: StateStorage<ToggleStateItem> { }

class StateStorage<StateItem>: ObservableObject {
    
    @Published
    var states: [ToggleState: StateItem]
    
    @Published
    var state: ToggleState
    
    init(
        states: [ToggleState : StateItem],
        state: ToggleState = .off
    ) {
        self.states = states
        self.state = state
    }
    
    subscript<T>(keyPath: KeyPath<StateItem, T?>) -> T? {
        if let item = states[state]?[keyPath: keyPath] {
            return item
        }
        return states[.off]?[keyPath: keyPath]
    }
}

// MARK: - ToggleStateItem
public struct ToggleStateItem {
    
    let backgroundColor: Color?
    let shadowColor: Color?
    
    public init(
        backgroundColor: Color = .clear,
        shadowColor: Color = .clear
    ) {
        self.backgroundColor = backgroundColor
        self.shadowColor = shadowColor
    }
    
    public func editing(with item: ToggleStateItem) -> ToggleStateItem {
        return .init(
            backgroundColor: item[\.backgroundColor, self] ?? .clear,
            shadowColor: item[\.shadowColor, self] ?? .clear
        )
    }
    
    private subscript<T>(keyPath: KeyPath<Self, T?>, _ defaultValue: Self) -> T? {
        self[keyPath: keyPath] ?? defaultValue[keyPath: keyPath]
    }
}
