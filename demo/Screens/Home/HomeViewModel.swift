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
    
    private(set) var shouldChangeCharacterSubject: PassthroughSubject<Void, Never> = .init()
    private var cancellables: Set<AnyCancellable> = []
    
    private let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    init() {
        subscribeShouldChangeCharacter()
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
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
}

// MARK: - PRIVATE METHODS
extension HomeViewModel {
    private func subscribeShouldChangeCharacter() {
        shouldChangeCharacterSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                do {
                    if try self.isValidEmail() {
                        BSLogger.debug("valid")
                    } else {
                        BSLogger.debug("invalid")
                    }
                } catch {
                    BSLogger.error(error)
                }
            }
            .store(in: &cancellables)
    }
    
    private func isValidEmail() throws -> Bool {
        let regex = try NSRegularExpression(pattern: emailPattern)
        
        let result = regex.matches(in: email, range: NSMakeRange(.zero, email.count))
        return result.count > 0
    }
}
