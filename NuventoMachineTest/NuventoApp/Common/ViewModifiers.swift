//
//  ViewModifiers.swift
//  NuventoMachineTest
//
//  Created by Thirumalai Ganesh G on 30/01/26.
//

import Foundation
import SwiftUI

// MARK: - Button Modifier
struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.system(size: 20, weight: .bold))
            .background(.purple)
            .foregroundStyle(.white)
            .clipShape(.capsule)
            .clipped()
    }
}

// MARK: - Text Modifier
struct TextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.system(size: 15, weight: .medium))
    }
}

// MARK: - Keyboard Modifier
struct KeyboardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture(perform: {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            })
    }
}

extension View {
    func nuventoTextStyle() -> some View {
        self.modifier(TextModifier())
    }
    
    func nuventoButtonStyle() -> some View {
        self.modifier(ButtonModifier())
    }
    
    func resignKeyboard() -> some View {
        self.modifier(KeyboardModifier())
    }
}


