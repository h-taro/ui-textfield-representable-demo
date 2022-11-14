//
//  PasswordTextField.swift
//  demo
//
//  Created by 平石　太郎 on 2022/11/11.
//

import SwiftUI

struct PasswordTextField: View {
    @State private var isSecure = false

    private var password: Binding<String>
    private let placeholder: String
    
    private var eyeButtonName: String {
        isSecure ? "eye.slash" : "eye"
    }
    
    init(password: Binding<String>, placeholder: String) {
        self.password = password
        self.placeholder = placeholder
    }

    var body: some View {
        UITextFieldRepresentable(
            text: password,
            isSecure: $isSecure,
            placeholder: placeholder,
            keyboardType: .default
        )
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.1))
        )
        .overlay(
            HStack(alignment: .center, spacing: .zero) {
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: eyeButtonName)
                        .padding(.trailing, 16)
                }
            }
        )
    }
}
