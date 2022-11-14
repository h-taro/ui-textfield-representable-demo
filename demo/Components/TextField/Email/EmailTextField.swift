//
//  EmailTextField.swift
//  demo
//
//  Created by 平石　太郎 on 2022/11/11.
//

import SwiftUI

// TODO: フォーカス時にスタイルを変更する
struct EmailTextField: View {
    @StateObject private var viewModel: EmailTextFieldViewModel = .init()

    private var text: Binding<String>
    private let placeholder: String
    
    init(
        text: Binding<String>,
        placeholder: String
    ) {
        self.text = text
        self.placeholder = placeholder
    }

    var body: some View {
        UITextFieldRepresentable(
            text: text,
            isSecure: .constant(false),
            placeholder: placeholder,
            keyboardType: .emailAddress
        )
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.1))
        )
    }
}
