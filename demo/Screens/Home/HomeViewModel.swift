//
//  HomeViewModel.swift
//  demo
//
//  Created by 平石　太郎 on 2022/11/10.
//

/**
 
 */
import Foundation
import BSLogger
import Combine

class HomeViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    private let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    func onTapDone() {
        do {
            if try isValidEmail() {
                BSLogger.debug("valid")
            } else {
                BSLogger.debug("invalid")
            }
        } catch {
            BSLogger.error(error)
        }
    }
    
    private func isValidEmail() throws -> Bool {
        let regex = try NSRegularExpression(pattern: emailPattern)
        
        let result = regex.matches(in: email, range: NSMakeRange(.zero, email.count))
        return result.count > 0
    }
}
