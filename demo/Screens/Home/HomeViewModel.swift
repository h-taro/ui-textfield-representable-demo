//
//  HomeViewModel.swift
//  demo
//
//  Created by 平石　太郎 on 2022/11/10.
//

/**
 
 */
import Foundation
import THLogger
import Combine

class HomeViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var hoge = ""
    @Published var focusTag: Int? = nil
    @Published private(set) var isShowErrorView = false
    
    private(set) var emailValidSubject: PassthroughSubject<Bool, Never> = .init()
    private(set) var shouldReturnSubject: PassthroughSubject<Void, Never> = .init()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        subscribeEmailValid()
        subscribeHoge()
        subscribeShouldReturn()
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    func onTapDone() {
    }
}

// MARK: - PRIVATE METHODS
extension HomeViewModel {
    private func subscribeShouldReturn() {
        shouldReturnSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                if self.focusTag == nil {
                    self.focusTag = .zero
                } else if self.focusTag == .zero {
                    self.focusTag = 1
                } else if self.focusTag == 1 {
                    self.focusTag = 2
                } else {
                    self.focusTag = .zero
                }
            }
            .store(in: &cancellables)
    }

    private func subscribeHoge() {
        $hoge
            .receive(on: DispatchQueue.main)
            .sink { [weak self] output in
                guard let self = self else { return }
                THLogger.debug(output)
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
