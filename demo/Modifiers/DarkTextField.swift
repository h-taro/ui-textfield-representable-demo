//
//  DarkTextField.swift
//  demo
//
//  Created by 平石　太郎 on 2022/11/10.
//

import SwiftUI

struct DarkTextField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 20)
            .padding(.vertical, 4)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2))
            )
    }
}

extension View {
    func darkTextFieldStyle() -> some View {
        self.modifier(DarkTextField())
    }
}
