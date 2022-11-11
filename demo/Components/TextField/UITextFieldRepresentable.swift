//
//  UITextFieldRepresentable.swift
//  demo
//
//  Created by 平石　太郎 on 2022/11/11.
//

import BSLogger
import SwiftUI

struct UITextFieldRepresentable: UIViewRepresentable {
    @Binding var text: String
    
    private let placeholder: String
    private let keyboardType: UIKeyboardType
    
    init(
        text: Binding<String>,
        placeholder: String,
        keyboardType: UIKeyboardType
    ) {
        self._text = text
        self.placeholder = placeholder
        self.keyboardType = keyboardType
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        
        textField.delegate = context.coordinator
        textField.placeholder = placeholder
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.keyboardType = keyboardType
        
        let toolBar = UIToolbar(frame: CGRect(x: .zero, y: .zero, width: textField.frame.size.width, height: 44))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(
            title: "完了",
            style: .done,
            target: context.coordinator,
            action: #selector(context.coordinator.onTapDoneButton(_:))
        )
        
        toolBar.setItems([spacer, doneButton], animated: true)
        textField.inputAccessoryView = toolBar
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        private var parent: UITextFieldRepresentable
        
        init(_ parent: UITextFieldRepresentable) {
            self.parent = parent
        }
        
        @objc func onTapDoneButton(_ button: UIBarButtonItem) {
            UIApplication.shared.endEditing()
        }
    }
}
