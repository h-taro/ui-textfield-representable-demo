//
//  HomeViewModel.swift
//  demo
//
//  Created by 平石　太郎 on 2022/11/10.
//

import BSLogger
import Combine

class HomeViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func onTapDone() {
        BSLogger.debug("email: \(email)")
        BSLogger.debug("password: \(password)")
    }
}
