//
//  FugaTextFieldRepresentable.swift
//  demo
//
//  Created by 平石　太郎 on 2022/11/16.
//

import THLogger
import Combine
import SwiftUI

struct FugaTextFieldRepresentable: UIViewRepresentable {
    @Binding var text: String
    @Binding var focusTag: Int?
    
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
        self._text = text
        self._focusTag = focusTag
        self.tag = tag
        self.placeholder = placeholder
        self.shouldReturnSubject = shouldReturnSubject
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        
        textField.placeholder = placeholder
        textField.tag = tag
        textField.delegate = context.coordinator
        
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
        guard let focusTag = focusTag else { return }
        if uiView.tag == focusTag {
            
            THLogger.debug(focusTag)
            uiView.becomeFirstResponder()
        }
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        private let parent: FugaTextFieldRepresentable
        
        init(_ parent: FugaTextFieldRepresentable) {
            self.parent = parent
        }
        
        @objc func onTapDoneButton(_ button: UIBarButtonItem) {
            UIApplication.shared.endEditing()
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            parent.shouldReturnSubject.send()
            return true
        }
    }
}
