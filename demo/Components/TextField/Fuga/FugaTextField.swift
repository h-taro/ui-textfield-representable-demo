//
//  FugaTextField.swift
//  demo
//
//  Created by 平石　太郎 on 2022/11/16.
//

import Combine
import SwiftUI

struct FugaTextField: View {
    private var text: Binding<String>
    private let focusTag: Binding<Int?>
    
    private let tag: Int
    private let placeholder: String
    private let shouldReturnSubject: PassthroughSubject<Void, Never>
    
    init(
        text: Binding<String>,
        focusTag: Binding<Int?>,
        tag: Int,
        placeholder: String,
        shouldReturnSubject: PassthroughSubject<Void, Never>
    ) {
        self.text = text
        self.focusTag = focusTag
        self.tag = tag
        self.placeholder = placeholder
        self.shouldReturnSubject = shouldReturnSubject
    }
    
    var body: some View {
        FugaTextFieldRepresentable(
            text: text,
            focusTag: focusTag,
            tag: tag,
            placeholder: placeholder,
            shouldReturnSubject: shouldReturnSubject
        )
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.1))
        )
    }
}
