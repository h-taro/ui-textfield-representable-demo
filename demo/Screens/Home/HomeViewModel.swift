//
//  HomeViewModel.swift
//  demo
//
//  Created by 平石　太郎 on 2022/11/10.
//

import Combine

class HomeViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isPresented = false
    
    func onTapDone() {
        isPresented = true
    }
}
