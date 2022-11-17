//
//  HogeTextFieldRepresentable.swift
//  demo
//
//  Created by 平石　太郎 on 2022/11/15.
//

// TODO: textField.addTarget(..., for: .editingChanged)
import SwiftUI

struct HogeTextFieldRepresentable: UIViewRepresentable {
    @Binding var text: String
    
    private let keyboardType: UIKeyboardType
    
    init(
        text: Binding<String>,
        keyboardType: UIKeyboardType
    ) {
        self._text = text
        self.keyboardType = keyboardType
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        
        textField.delegate = context.coordinator
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.keyboardType = keyboardType
        
        textField.addTarget(context.coordinator, action: #selector(context.coordinator.onEditingChanged(_:)), for: .editingChanged)
        
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
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        private let parent: HogeTextFieldRepresentable
        
        init(_ parent: HogeTextFieldRepresentable) {
            self.parent = parent
        }
        
        @objc func onTapDoneButton(_ button: UIBarButtonItem) {
            UIApplication.shared.endEditing()
        }
        
        @objc func onEditingChanged(_ textField: UITextField) {
            if let text = textField.text {
                parent.text = text
            }
        }
    }
}
