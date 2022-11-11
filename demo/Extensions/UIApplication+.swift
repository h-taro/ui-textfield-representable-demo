//
//  UIApplication+.swift
//  demo
//
//  Created by 平石　太郎 on 2022/11/11.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
