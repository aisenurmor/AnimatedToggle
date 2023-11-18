//
//  ToggleState.swift
//  
//
//  Created by Aise Nur Mor on 15.11.2023.
//

import SwiftUI

public enum ToggleState {
    case on
    case off
    
    init(rawValue: Bool) {
        self = rawValue ? .on : .off
    }
    
    var rawValue: Bool {
        self == .on
    }
    
    public var style: ToggleStateItem {
        switch self {
        case .on:
            return .init(
                backgroundColor: .green,
                shadowColor: .green.opacity(0.4)
            )
        case .off:
            return .init(
                backgroundColor: .pink,
                shadowColor: .pink.opacity(0.4)
            )
        }
    }
    
    var alignment: Alignment {
        switch self {
        case .on:
            return .trailing
        case .off:
            return .leading
        }
    }
    
    mutating func toggle() {
        switch self {
        case .on:
            self = .off
        case .off:
            self = .on
        }
    }
}
