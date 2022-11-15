//
//  HogeTextField.swift
//  demo
//
//  Created by 平石　太郎 on 2022/11/15.
//

import SwiftUI

struct HogeTextField: View {
    private var hoge: Binding<String>
    
    init(hoge: Binding<String>) {
        self.hoge = hoge
    }
    
    var body: some View {
        HogeTextFieldRepresentable(
            text: hoge,
            keyboardType: .default
        )
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.1))
        )
    }
}
