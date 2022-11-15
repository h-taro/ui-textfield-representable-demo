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
    @Published var hoge = ""
    @Published private(set) var isShowErrorView = false
    
    private(set) var emailValidSubject: PassthroughSubject<Bool, Never> = .init()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        subscribeEmailValid()
        subscribeHoge()
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    func onTapDone() {
    }
}

// MARK: - PRIVATE METHODS
extension HomeViewModel {
    private func subscribeHoge() {
        $hoge
            .receive(on: DispatchQueue.main)
            .sink { [weak self] output in
                guard let self = self else { return }
                BSLogger.debug(output)
            }
            .store(in: &cancellables)
    }

    private func subscribeEmailValid() {
        emailValidSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] valid in
                guard let self = self else { return }
                self.isShowErrorView = !valid
            }
            .store(in: &cancellables)
    }
}
