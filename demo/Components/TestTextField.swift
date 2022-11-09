//
//  TestTextField.swift
//  demo
//
//  Created by 平石　太郎 on 2022/11/10.
//

import BSLogger
import SwiftUI

struct TestTextField: UIViewRepresentable {
    @Binding var text: String
    private var keyboardType: UIKeyboardType
    
    init(text: Binding<String>, keyboardType: UIKeyboardType) {
        self._text = text
        self.keyboardType = keyboardType
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.keyboardType = keyboardType
        
        let toolBar = UIToolbar(frame: CGRect(x: .zero, y: .zero, width: textField.frame.size.width, height: 44))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .done, target: context.coordinator, action: #selector(context.coordinator.onTapCancelButton(button:)))
        let clearButton = UIBarButtonItem(title: "Clear", style: .done, target: context.coordinator, action: #selector(context.coordinator.onTapClearButton(button:)))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: context.coordinator, action: #selector(context.coordinator.onTapDoneButton(button:)))
        
        toolBar.setItems([cancelButton, clearButton, spacer, doneButton], animated: true)
        textField.inputAccessoryView = toolBar
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        private let parent: TestTextField
        
        init(_ parent: TestTextField) {
            self.parent = parent
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
        @objc func onTapCancelButton(button: UIBarButtonItem) {
            BSLogger.debug("on tap cancel button")
        }
        
        @objc func onTapClearButton(button: UIBarButtonItem) {
            BSLogger.debug("on tap clear button")
        }
        
        @objc func onTapDoneButton(button: UIBarButtonItem) {
            BSLogger.debug("on tap done button")
        }
    }
}
