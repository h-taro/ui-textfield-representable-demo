//
//  HomeViewModel.swift
//  demo
//
//  Created by 平石　太郎 on 2022/11/10.
//

import Combine

class HomeViewModel: ObservableObject {
    @Published var text1 = "first"
    @Published var text2 = "second"
    @Published var text3 = "third"
}
