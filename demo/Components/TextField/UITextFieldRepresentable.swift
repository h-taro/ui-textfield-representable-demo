//
//  UITextFieldRepresentable.swift
//  demo
//
//  Created by 平石　太郎 on 2022/11/11.
//

import Combine
import BSLogger
import SwiftUI

struct UITextFieldRepresentable: UIViewRepresentable {
    @Binding var text: String
    @Binding var isSecure: Bool
    
    private let placeholder: String
    private let keyboardType: UIKeyboardType
    
    private let shouldChangeCharacterSubject: PassthroughSubject<Void, Never>
    
    init(
        text: Binding<String>,
        isSecure: Binding<Bool>,
        placeholder: String,
        keyboardType: UIKeyboardType,
        shouldChangeCharacterSubject: PassthroughSubject<Void, Never>
    ) {
        self._text = text
        self._isSecure = isSecure
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.shouldChangeCharacterSubject = shouldChangeCharacterSubject
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
        BSLogger.debug("update ui view")
        uiView.text = text
        uiView.isSecureTextEntry = isSecure
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        private var parent: UITextFieldRepresentable
        
        init(_ parent: UITextFieldRepresentable) {
            self.parent = parent
        }
        
        @objc func onTapDoneButton(_ button: UIBarButtonItem) {
            UIApplication.shared.endEditing()
        }
        
        /**
         指定されたテキスト フィールドで編集を開始するかどうかをデリゲートに尋ねます。
         */
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            BSLogger.debug("入力可能になる直前")
            return true
        }
        
        /**
         指定されたテキスト フィールドで編集が開始されたときにデリゲートに通知します。
         
         */
        func textFieldDidBeginEditing(_ textField: UITextField) {
            BSLogger.debug("入力可能になった後")
        }
        
        /**
         指定されたテキスト フィールドでの編集を停止するかどうかをデリゲートに尋ねます。
         */
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            BSLogger.debug("キーボードが閉じる直前")
            return true
        }
        
        /**
         指定されたテキスト フィールドの編集がいつ停止したか、および停止した理由をデリゲートに通知します。
         */
        func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
            BSLogger.debug(reason)
        }
        
        /**
         指定されたテキスト フィールドの編集が停止したときにデリゲートに通知します。
         */
        func textFieldDidEndEditing(_ textField: UITextField) {
            BSLogger.debug("キーボードが閉じた後")
        }
        
        /**
         テキスト フィールドの現在の内容を削除するかどうかをデリゲートに尋ねます。
         */
        func textFieldShouldClear(_ textField: UITextField) -> Bool {
            BSLogger.debug("テキストがクリアされる直前")
            return true
        }
        
        /**
         テキスト フィールドの [戻る] ボタンの押下を処理するかどうかをデリゲートに問い合わせます。
         */
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            BSLogger.debug("Returnが押される直前")
            return true
        }
        
        /**
         指定されたテキストを変更するかどうかデリゲートに尋ねます。
         */
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let text = textField.text {
                parent.text = text
            } else {
                parent.text = ""
            }
            
            parent.shouldChangeCharacterSubject.send()
            return true
        }
    }
}
