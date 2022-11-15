//
//  EmailTextFieldViewModel.swift
//  demo
//
//  Created by 平石　太郎 on 2022/11/14.
//

import BSLogger
import Foundation
import Combine

class EmailTextFieldViewModel: ObservableObject {
    private(set) var shouldChangeCharacterSubject: PassthroughSubject<String, Never> = .init()
    private let emailValidSubject: PassthroughSubject<Bool, Never>
    private var cancellables: Set<AnyCancellable> = []
    
    private let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    init(emailValidSubject: PassthroughSubject<Bool, Never>) {
        self.emailValidSubject = emailValidSubject

        subscribeShouldChangeCharacter()
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
}

// MARK: - PRIVATE METHODS
extension EmailTextFieldViewModel {
    private func subscribeShouldChangeCharacter() {
        shouldChangeCharacterSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] text in
                BSLogger.debug(text)

                guard let self = self else { return }
                
                do {
                    if try self.isValidEmail(text) {
                        self.emailValidSubject.send(true)
                    } else {
                        self.emailValidSubject.send(false)
                    }
                } catch {
                    BSLogger.error(error)
                }
            }
            .store(in: &cancellables)
    }
    
    private func isValidEmail(_ email: String) throws -> Bool {
        let regex = try NSRegularExpression(pattern: emailPattern)
        
        let result = regex.matches(in: email, range: NSMakeRange(.zero, email.count))
        return result.count > 0
    }
}
